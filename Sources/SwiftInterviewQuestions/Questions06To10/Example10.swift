enum Question10 {
    static func run() {
        let input = "{[()()]()[]}"
        print("inputString: \(input)")
        let result = checkRightOrder(input)
        print("Is properly ordered: \(result)")
    }

    static func firstBalancedBracketContentRange(_ input: String) -> (startIndex: String.Index, endIndex: String.Index)? {        
        let startIndex = input.startIndex 

        var bracketCount = 0
        var currentIndex = startIndex

        let character = input.first ?? Character(" ") // Define a default character if the string is empty
        let closingCharacter = pairCharacters(character)

        if closingCharacter == " " {
            return nil // Invalid input: not opening character
        }

        while currentIndex < input.endIndex {
            let char = input[currentIndex]

            if char == character {
                bracketCount += 1
            } else if char == closingCharacter {
                bracketCount -= 1

                if bracketCount == 0 {
                    let contentStart = input.index(after: startIndex)             
                    return (contentStart, currentIndex)
                }
            }   

            currentIndex = input.index(after: currentIndex)
        }

        return nil // No matching closing bracket
    } 

    static func pairCharacters(_ input: Character) -> Character {
        let pairs: [Character: Character] = ["[": "]", "(": ")", "{": "}"]
        let emptyCharacter: Character = " " // Define an empty character or use a default value
        return pairs[input] ?? emptyCharacter // Return a space or some default character if not found
    }

    static func checkRightOrder(_ input: String) -> Bool {
        if input.count == 0 {
            // print(input+" is properly ordered!")
            return true
        }

        guard let (startIndex, endIndex) = firstBalancedBracketContentRange(input)  else {
            print(input+" is not properly ordered")
            return false
        }

        let start = startIndex
        let end = endIndex

        let content = input[start..<end]
        // print(content)
        return  checkRightOrder(String(content)) && checkRightOrder(String(input[input.index(after: end)...]))
    }

}

