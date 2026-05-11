enum Question08: InterviewQuestion {
    static func run() {
        Solution().run()
    }   

    static func countLetters(_ str: String) -> [Character: Int] {

        var map: [Character: Int] = [:]

        for char in str {
            if char.isLetter{
                map[char, default: 0] += 1
            }

        }
        return map
    }


}

class Solution {
    let string = "Hello world"

    lazy var map = Question08.countLetters(string)

    func run() {
        for (char, count) in map {
            print("\(char): \(count)")
        }
    }

}