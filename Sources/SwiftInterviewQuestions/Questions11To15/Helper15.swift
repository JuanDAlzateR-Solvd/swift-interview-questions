import Foundation

struct RootResponse: Decodable {
    let channel: Channel
}

struct Channel: Decodable {
    let id: String
    let name: String
    let subscribers: [UserReference]
    let videos: [Video]

    func getMostViewedVideo() -> (Video, Int)? {
        guard var mostViewed = videos.first else{
            print("No videos")
            return nil
        }
        var mostViews = mostViewed.stats.totalViews

        for video in videos {
            let videoViews = video.stats.totalViews
            if videoViews > mostViews{
                mostViews = videoViews
                mostViewed = video
            }
        }
        return (mostViewed, mostViews)
    }

    func getSubsComments() -> [String:[Comment]] {
        var subsComments: [String:[Comment]] = [:]
        for video in videos{
            let videoComments = video.stats.getSubsComments()
            for (id, comments) in videoComments {
                subsComments[id, default: []].append(contentsOf: comments)
            }            
        }
        return subsComments
    }

    func getSpamComments() -> [String:[Comment]] {
        var spamComments: [String:[Comment]] = [:]
        for video in videos{
            let videoComments = video.stats.getSpamComments()
            for (author, comments) in videoComments {
                spamComments[author, default: []].append(contentsOf: comments)
            }            
        }
        return spamComments
    }


}

struct UserReference: Decodable, Hashable {
    let id: String
}

struct Video: Decodable {
    let id: String
    let name: String
    let duration: String
    let props: VideoProps
    let stats: VideoStats

    func calculateAverageViewPercentage() -> Double{
        guard let totalSeconds = durationInSeconds(from: duration), totalSeconds>0 else{
            print("Duration: \(duration) \t totalSeconds: \(durationInSeconds(from: duration))")
            print("Error")
            return 0
        }        
        return stats.calculateAverageViewPercent(totalDuration: totalSeconds)
    }
}

struct VideoProps: Decodable {
    let video: VideoInfo
    let audio: AudioInfo
}

struct VideoInfo: Decodable {
    let url: String
    let thumbnail: String
    let quality: [String]
}

struct AudioInfo: Decodable {
    let codec: String
    let bitrate: String
}

struct VideoStats: Decodable {
    let views: [ViewRecord]
    let rating: Rating
    let comments: [Comment]

    var totalViews: Int {
        calculateTotalViews()
    }

    func calculateTotalViewSecondsPerUser() -> [UserReference:Int]{
        var total:[UserReference:Int] = [:]
        for viewRecord in views{
            let user = viewRecord.user
            total[user, default: 0]+=viewRecord.getViewSeconds()
        }
        return total
    }

    func calculateTotalViews() ->Int{
        let viewSecondsPerUser = calculateTotalViewSecondsPerUser()
        var count = 0
        for (user, viewSeconds) in viewSecondsPerUser{
            if (viewSeconds>=30){
                count+=1
            }            
        }         
        return count
    }

    func getSubsComments() -> [String:[Comment]] {
        var subsComments: [String:[Comment]] = [:]
        for comment in comments{
            let userId = userIdFrom(author: comment.author)
            subsComments[userId, default: []].append(comment)
        }
        return subsComments
    }

    func getSpamComments() -> [String:[Comment]] {
        var spamComments: [String:[Comment]] = [:]
        for comment in comments{              
            if (isSpam(comment.content)){
                spamComments[comment.author, default: []].append(comment)
            }
        }
        return spamComments
    }

    private func calculateTotalViewSeconds() -> Int {
                var total = 0
        for viewRecord in views {
            total+=viewRecord.getViewSeconds()
        }
        return total
    }

    func calculateAverageViewSeconds() -> Double {
        let total = calculateTotalViewSeconds()
        return Double(total)/Double(views.count)
    }

    func calculateAverageViewPercent(totalDuration: Int) -> Double{
        let total = calculateTotalViewSeconds()
        return Double(total*100)/Double(views.count*totalDuration)
    }
    
}

struct ViewRecord: Decodable {
    let user: UserReference
    let timestamp: Date
    let window: String

    func getViewSeconds()->Int{
        if window.contains("-"){
           let limits = window.split(separator: "-")
        let start = Int(limits[0]) ?? 0
        let finish = Int(limits[1]) ?? 0
            return finish-start
        }else{
            return Int(window) ?? 0
        }
    }

    func getViewPercentage(totalDuration: Int) -> Double {
        return Double(getViewSeconds())/Double(totalDuration)
    }
}

struct Rating: Decodable {
    let likes: [Reaction]
    let dislikes: [Reaction]
}

struct Reaction: Decodable {
    let user: UserReference
    let timestamp: Date
}

struct Comment: Decodable {
    let id: String
    let author: String
    let content: String
    let stats: CommentStats
}

struct CommentStats: Decodable {
    let rating: Rating
}

func userIdFrom(author: String) -> String {
    let parts = author.split(separator: "@")
    return String(parts[1].dropLast())
}

func durationInSeconds(from duration: String) -> Int? {
    let parts = duration.split(separator: ":")

    if parts.count == 3 {
        guard let hours = Int(parts[0]),
              let minutes = Int(parts[1]),
              let seconds = Int(parts[2]) else {
            return nil
        }

        return hours * 3600 + minutes * 60 + seconds
    }

    if parts.count == 2 {
        guard let minutes = Int(parts[0]),
              let seconds = Int(parts[1]) else {
            return nil
        }

        return minutes * 60 + seconds
    }

    return nil
}

func isSpam(_ message: String) -> Bool {
    let spamKeywords = ["http", ".com"]
    
    // Verifies if at least one spam keyword it's on the message
    return spamKeywords.contains { keyword in
        message.lowercased().contains(keyword)
    }
}
