enum Question03v4: InterviewQuestion {
    static func run() {
        let input = "start2[b3[cd]middle5[f]]end"
        print("EncodedString: \(input)")
        let result = decodeString(input) 
        print("DecodedString: \(result)")

    }

    static func decodeString(_ s: String) -> String {
        let cursor = StringCursor(s)
        return decode(cursor)
    }

    static func decode(_ cursor: StringCursor) -> String {
        var result = ""
        var multiplier = 0
        
        while let char = cursor.currentChar {
            switch char {
            case "0"..."9":
                multiplier = parseFullNumber(cursor)
            case "[":
                //Recursive call to decode the content inside the brackets, and repeat it according to the multiplier
                result += processBracketContent(cursor, times: multiplier)
                multiplier = 0 
            case "]":
                cursor.increment() 
                return result      
            default:
                result.append(char)
                cursor.increment()
            }
        }
        return result
    }

    static func parseFullNumber(_ cursor: StringCursor) -> Int {
        var num = 0
        while let char = cursor.currentChar, char.isNumber {
            num = num * 10 + (char.wholeNumberValue ?? 0)
            cursor.increment()
        }
        return num
    }
    
    static func processBracketContent(_ cursor: StringCursor, times: Int) -> String {
        cursor.increment() // Salta '['
        let repeatedContent = decode(cursor) 
        return String(repeating: repeatedContent, count: times)
    }


    class StringCursor {
      let text: String
      private(set) var currentIndex: String.Index
      
      init(_ text: String) {
          self.text = text
          self.currentIndex = text.startIndex
      }
           
      func increment() {
          if currentIndex < text.endIndex {
              currentIndex = text.index(after: currentIndex)
          }
      }      
            
      var currentChar: Character? {
          guard currentIndex < text.endIndex else { return nil }
          return text[currentIndex]
      }      
      
      var isAtEnd: Bool {
          return currentIndex == text.endIndex
      }
    }
    
}