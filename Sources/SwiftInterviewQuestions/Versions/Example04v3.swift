enum Question04v3: InterviewQuestion {
	static func run() {

		//Code ready to run in one compiler:

		//RUN CODE

		let str1 = "hello"
		let str2 = "olleh"
		let result = areReversed(str1, str2)
		print("Input: \(str1), \(str2)")
		print("are reversed? \(result)")

		//CLASSES AND FUNCTIONS

		func areReversed(_ str1: String, _ str2: String) -> Bool {

			guard str1.count == str2.count else {
				return false
			}

			var index1 = str1.startIndex
			var index2 = str2.endIndex

			let end = str1.endIndex

			while index1 < end {

				index2 = str2.index(before: index2)

				if str1[index1] != str2[index2] {
					return false
				}

				index1 = str1.index(after: index1)

			}
			return true

		}

	}
}
