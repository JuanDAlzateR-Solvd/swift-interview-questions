enum Question05v2: InterviewQuestion {

	static func run() {

		let info: [String: [String: [String: Int]]] = [
            "2021-12-23": [
                "new reddit": ["uniques": 111902, "pageviews": 221081],
                "android":    ["uniques": 298063, "pageviews": 1153728],
                "old reddit": ["uniques": 132801, "pageviews": 723509],
                "ios":        ["uniques": 311642, "pageviews": 755030],
                "mobile web": ["uniques": 130288, "pageviews": 219457]
            ],
            "2021-12-22": [
                "new reddit": ["uniques": 118371, "pageviews": 225093],
                "android":    ["uniques": 280199, "pageviews": 1291546],
                "old reddit": ["uniques": 145437, "pageviews": 760191],
                "ios":        ["uniques": 257443, "pageviews": 575184],
                "mobile web": ["uniques": 116411, "pageviews": 191464]
            ],
            "2021-12-21": [
                "new reddit": ["uniques": 175446, "pageviews": 300378],
                "android":    ["uniques": 331628, "pageviews": 1613490],
                "old reddit": ["uniques": 164052, "pageviews": 830788],
                "ios":        ["uniques": 288464, "pageviews": 626490],
                "mobile web": ["uniques": 111844, "pageviews": 193197]
            ],
            "2021-12-10": [
                "new reddit": ["uniques": 140548, "pageviews": 267522],
                "android":    ["uniques": 375491, "pageviews": 1336061],
                "old reddit": ["uniques": 189477, "pageviews": 957462],
                "ios":        ["uniques": 418290, "pageviews": 985014],
                "mobile web": ["uniques": 198403, "pageviews": 336195]
            ]
		]


		let last2DaysPageviews = getLastNDaysPageviews(from: info, days: 2)
		print("Total pageviews for the last 2 days: \(last2DaysPageviews)")
	}

	static func getLastNDaysPageviews(from data: [String: [String: [String: Int]]], days: Int) -> Int {     

		let sortedDates = data.keys.sorted(by: >)
		let lastNDays = sortedDates.prefix(days)

		var totalViews = 0
		for date in lastNDays{
			if let platforms = data[date]{	
				for platform in platforms.keys{
					if let pageviews = platforms[platform]?["pageviews"]{
						totalViews += pageviews
					}
				}
			}
		}
		return totalViews
	}



}