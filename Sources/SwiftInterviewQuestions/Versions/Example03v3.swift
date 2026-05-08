enum Question03v3: InterviewQuestion {
    static func run() {
        let input = "start2[b3[cd]middle5[f]]end"
        print("EncodedString: \(input)")
        let result = decode(input) 
        print("DecodedString: \(result)")

    }

    static func extractContentInBrackets(_ str: String) -> (String.Index,String.Index){
      var n = 0
 
      var cursor = StringCursor(str)
      
      while(cursor.currentChar != "["){
        
        cursor.increment()      

        if (cursor.isAtEnd){
          return (str.startIndex,str.endIndex)
        }
      }
  
      n += 1
      let start = cursor.getIndex()
      
      while (n>0){
        if (cursor.isAtEnd){
          print("Unbalanced brackets")
          return (str.endIndex,str.endIndex)
        }
        
        cursor.increment()
        if (cursor.currentChar == "["){
          n += 1
        } else if (cursor.currentChar == "]"){
          n -= 1
        }
        
      }
      
      let end = cursor.getIndex()
      return (start,end)
  }

    static func splitWordAndNumber(_ str: String) -> (word:String, number: Int){

      let cursor = StringCursor(str)

      let start = str.startIndex
   
      let end = str.endIndex
      let digits = "0123456789"

      while(!digits.contains(cursor.currentChar)){
        cursor.increment()
        if (cursor.isAtEnd){
          return (str, 1)
        }
      }
      
      let word = cursor.getPrefix()
      let number = Int(cursor.getSuffix()) ?? 1
      return (word, number)
      
    }

    static func decode(_ str: String) -> String{
      guard str != "" else {
        return str
      }

      let cursor = StringCursor(str)
      
      let (start, end) = extractContentInBrackets(str)
      let prefix = cursor.substring(from: str.startIndex, to: start)
      
      guard start != str.startIndex && end != str.endIndex else {
        return str
      }
      guard start != end else {
        return ""
      }

      let start2 = str.index(after: start)
      let content = cursor.substring(from: start2, to: end)
      
      var sufix = ""
      if (end != str.endIndex){
          let end2 = str.index(after: end)
          sufix = cursor.substring(from: end2, to: str.endIndex)
      }
      
      let (word, number) = splitWordAndNumber(prefix)
              
      return word + String(repeating: decode(content), count: number) + decode(sufix)
    }


    class StringCursor {
      let text: String
      private(set) var currentIndex: String.Index
      
      init(_ text: String) {
          self.text = text
          self.currentIndex = text.startIndex
      }

      func getIndex() -> String.Index {
          return currentIndex
      }
      
      // MARK: - Index Movement
      
      func increment() {
          if currentIndex < text.endIndex {
              currentIndex = text.index(after: currentIndex)
          }
      }
      
      func decrement() {
          if currentIndex > text.startIndex {
              currentIndex = text.index(before: currentIndex)
          }
      }
      
      func move(by offset: Int) {
          currentIndex = text.index(currentIndex, offsetBy: offset, limitedBy: text.endIndex) ?? text.endIndex
      }

      // MARK: - Extraction Methods
      
      var currentChar: Character {
          guard currentIndex < text.endIndex else { return "*" }
          return text[currentIndex]
      }      
      
      func getPrefix() -> String {
          return String(text[..<currentIndex])
      }
            
      func getSuffix() -> String {
          return String(text[currentIndex...])
      }
            
      func substring(from start: String.Index, to end: String.Index) -> String {
          guard start <= end else { return "" }
          return String(text[start..<end])
      }
      
      func substring(since start: String.Index) -> String {
          return substring(from: start, to: currentIndex)
      }

      var isAtEnd: Bool {
          return currentIndex == text.endIndex
      }
    }
    
}