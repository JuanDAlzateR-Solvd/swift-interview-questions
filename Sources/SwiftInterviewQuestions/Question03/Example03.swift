enum Question03 {
    static func run() {
        let input = "start2[b3[cd]middle5[f]]end"
        let result = returnString(input) 
        print(result)
    }
}

func extractParameterIndex(_ input: String) -> (startIndex: String.Index, endIndex: String.Index)? {
    guard let startIndex = input.firstIndex(of: "[") else {
        return nil
    }

    var bracketCount = 0
    var currentIndex = startIndex

    while currentIndex < input.endIndex {
        let char = input[currentIndex]

        if char == "[" {
            bracketCount += 1
        } else if char == "]" {
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

func returnString(_ input: String) -> String {
    guard let (startIndex, endIndex) = extractParameterIndex(input)  else {
        return input
    }
    let start = startIndex
    let end = endIndex

    let (prefix, number) = splitWordAndNumber(String(input[..<start].dropLast()))  // Remove the closing ']'
    let content = input[start..<end]
    return prefix + String(repeating: returnString(String(content)), count: number ?? 1) + returnString(String(input[input.index(after: end)...]))
}

func splitWordAndNumber(_ input: String) -> (word: String, number: Int?) {
    let word = input.prefix { !$0.isNumber }
    let numberPart = input.drop { !$0.isNumber }

    let number = Int(numberPart)

    return (String(word), number)
}