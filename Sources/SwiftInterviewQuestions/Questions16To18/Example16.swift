enum Question16 {
    static func run() {
        let input = "aaaabbcaaa"
        print("input: \(input)")
        let result = encodeString(input) 
        print("EncodedString: \(result)")
    }

    static func encodeString(_ input: String) -> String {
        let start: String.Index = input.startIndex
        let end = input.endIndex
        var next = start

        var encoded: String = ""

        while next < end {
            let (repeated, nextIndex) = countRepeatingCharacters(input, index: next)
            encoded += getEncodedCharacter(number: repeated, input: input[next])
            next = nextIndex
        }
        return encoded       
    }

    static func countRepeatingCharacters(_ input: String, index: String.Index) -> (repeated:Int, nextIndex: String.Index) {
        let startChar = input[index]
        let end = input.endIndex
        var n = 1
        var nextIndex = input.index(after: index)
        while (nextIndex < end && input[nextIndex] == startChar) {
            n += 1
            nextIndex = input.index(after: nextIndex)
        }
        return (n, nextIndex)
    }

    static func getEncodedCharacter(number: Int, input: Character) -> String {
        guard number > 0  else {
            return ""
        }
        if number == 1 {
            return String(input)
        } else {
            return "\(number)[\(input)]"
        }
     }
    
}
