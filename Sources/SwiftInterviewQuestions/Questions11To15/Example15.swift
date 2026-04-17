import Foundation

enum Question15 {
    static func run() {
        do {
            print("--- P1 ---")
            let root = try loadChannelInfo()

            let numberOfVideos = root.channel.videos.count
            let numberOfSubscribers = root.channel.subscribers.count
            print("Number of videos: \(numberOfVideos)")
            print("Number of subscribers: \(numberOfSubscribers)")
            let videos = root.channel.videos
            print("Videos:")
            for video in videos{
                print("name: \(video.name)    \t views: \(video.stats.calculateTotalViews())")
            }

            print("\n--- P2 ---")
            guard let (mostViewedVideo, mostViews) = root.channel.getMostViewedVideo() else {
                print("There are not videos") 
                return               
            }

            print("Most Viewed Video: \(mostViewedVideo.name)")
            print("Duration: \(mostViewedVideo.duration) ")
            print("Total Views: \(mostViews)")

            print("\n--- P3 ---")
            let subs = root.channel.subscribers
            let comments = root.channel.getSubsComments()
            for sub in subs{               
                print("\nSubscriber: \(sub.id)")      
                let subComments = comments[sub.id] ?? []
                for subComment in subComments {
                    print(subComment.content)
                }
            }

            print("\n--- P4 ---")
            for video in videos {
                let averageViewSeconds = video.stats.calculateAverageViewSeconds()
                let percentageView = video.calculateAverageViewPercentage()
                let average = String(format: "%.2f", averageViewSeconds)
                let percentage = String(format: "%.2f", percentageView)
                print ("Name: \(video.name) \t Average View Seconds: \(average) \t Average View Percentage: \(percentage)%")
            }

            print("\n--- P5 ---")
            let spam = root.channel.getSpamComments()
            for (author, comments) in spam{
                print ("\nAuthor: \(author) \t totalSpam: \(comments.count)")
                for comment in comments{
                    print(comment.content)
                }
            }
    
            print("\n--- P6 ---")



        } catch {
            print("Failed to load channel info: \(error)")
        }
    }

    static func loadChannelInfo() throws -> RootResponse {
        guard let url = Bundle.module.url(forResource: "demo", withExtension: "json") else {
            throw NSError(
                domain: "demoError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Could not find JSON file."]
            )
        }

        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode(RootResponse.self, from: data)
    }

    static func convertToId(subId: String) -> String {
        let parts = subId.split(separator: "-")
        return String(parts[1]) 
    } 

}