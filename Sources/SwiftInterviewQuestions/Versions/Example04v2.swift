enum Question04v2: InterviewQuestion {
	static func run() {
		let input = "A man, a plan, a canal: Panama"
		let result = isPalindrome(input) 
		print("Is \"\(input)\" a palindrome? \(result)")

		let firstString = "stressed"
		let secondString = "desserts"
		let areReverse = areReverseOfEachOther(firstString, secondString)
		print("Are \"\(firstString)\" and \"\(secondString)\" reverse of each other? \(areReverse)")
	}

	static func isPalindrome(_ str: String) -> Bool{
		
		let cleanedString = str.lowercased().filter() { $0.isLetter || $0.isNumber}
	
		let cursor1 = StringCursor(cleanedString)
		let cursor2 = StringCursor(cleanedString)
		cursor2.setToEnd()

		var i = 0
		let midsize = cursor1.text.count/2

		while(!cursor1.isAtEnd){
			if (i > midsize){
				return true
			}

			if (cursor1.currentChar != cursor2.currentChar){
				return false
			}
			i += 1
			cursor1.increment()
			cursor2.decrement()
		}
		return true
	}

	static func areReverseOfEachOther(_ str1: String, _ str2: String) -> Bool{

		let cleanedString1 = str1.lowercased().filter() { $0.isLetter || $0.isNumber}
		let cleanedString2 = str2.lowercased().filter() { $0.isLetter || $0.isNumber}

		let cursor1 = StringCursor(cleanedString1)
		let cursor2 = StringCursor(cleanedString2)
		cursor2.setToEnd()

		if (cursor1.text.count != cursor2.text.count){
			return false
		}

		while(!cursor1.isAtEnd && !cursor2.isAtStart){

			if (cursor1.currentChar != cursor2.currentChar){
				return false
			}
		
			cursor1.increment()
			cursor2.decrement()
		}
		return true

	}
	
	class StringCursor {
		let text: String
		private(set) var currentIndex: String.Index
		
		init(_ text: String) {
				self.text = text
				self.currentIndex = text.startIndex
		}

		func setToStart() {
				currentIndex = text.startIndex
		}

		func setToEnd() {
				currentIndex = text.endIndex
		}
					
		func increment() {
				if currentIndex < text.endIndex {
						currentIndex = text.index(after: currentIndex)
				}
		}      

		func decrement() {
				if currentIndex < text.endIndex {
						currentIndex = text.index(before: currentIndex)
				}
		}      
					
		var currentChar: Character? {
				guard currentIndex < text.endIndex else { return nil }
				return text[currentIndex]
		}      
		
		var isAtStart: Bool {
				return currentIndex == text.startIndex
		}

		var isAtEnd: Bool {
				return currentIndex == text.endIndex
		}
	}

}