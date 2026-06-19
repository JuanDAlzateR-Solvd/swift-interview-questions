enum Question05v3: InterviewQuestion {

    static func run() {

        //RUN CODE

        let test1: [String: [String: [String: Int]]] = [
            "2021-12-23": [
                "new reddit": ["uniques": 111902, "pageviews": 221081],
                "android": ["uniques": 298063, "pageviews": 1_153_728],
                "old reddit": ["uniques": 132801, "pageviews": 723509],
                "ios": ["uniques": 311642, "pageviews": 755030],
                "mobile web": ["uniques": 130288, "pageviews": 219457],
            ],
            "2021-12-22": [
                "new reddit": ["uniques": 118371, "pageviews": 225093],
                "android": ["uniques": 280199, "pageviews": 1_291_546],
                "old reddit": ["uniques": 145437, "pageviews": 760191],
                "ios": ["uniques": 257443, "pageviews": 575184],
                "mobile web": ["uniques": 116411, "pageviews": 191464],
            ],
            "2021-12-21": [
                "new reddit": ["uniques": 175446, "pageviews": 300378],
                "android": ["uniques": 331628, "pageviews": 1_613_490],
                "old reddit": ["uniques": 164052, "pageviews": 830788],
                "ios": ["uniques": 288464, "pageviews": 626490],
                "mobile web": ["uniques": 111844, "pageviews": 193197],
            ],
            "2021-12-10": [
                "new reddit": ["uniques": 140548, "pageviews": 267522],
                "android": ["uniques": 375491, "pageviews": 1_336_061],
                "old reddit": ["uniques": 189477, "pageviews": 957462],
                "ios": ["uniques": 418290, "pageviews": 985014],
                "mobile web": ["uniques": 198403, "pageviews": 336195],
            ],
        ]

        let result = solution(test1)
        printSolution(result)

        //CLASSES AND FUNCTIONS

        func solution(_ test: [String: [String: [String: Int]]]) -> [String: Int] {

            let days = test.keys.sorted()
            let lastDays = days.suffix(2)

            var result: [String: Int] = [:]

            for day in lastDays {
                var total = 0

                guard let testDay = test[day] else {
                    continue
                }

                for (_, values) in testDay {
                    total += values["pageviews"] ?? 0
                }

                result[day] = total
            }

            return result
        }

        func printSolution(_ dict: [String: Int]) {
            var totalViews = 0
            for (day, total) in result {
                print("day: \(day) \t totalViews: \(total)")
                totalViews += total
            }
            print(String(repeating: "-", count: 40))
            print("\t\t\t\t\t totalViews: \(totalViews)")
        }

    }

}
