enum Question04 {
    static func run() {
        let input = "A man, a plan, a canal: Panama"
        let result = isPalindrome(input) 
        print("Is \"\(input)\" a palindrome? \(result)")

        let firstString = "stressed"
        let secondString = "desserts"
        let areReverse = areReverseOfEachOther(firstString, secondString)
        print("Are \"\(firstString)\" and \"\(secondString)\" reverse of each other? \(areReverse)")
    }

    static func isPalindrome(_ input: String) -> Bool {
        let cleanedString = input.lowercased().filter { $0.isLetter || $0.isNumber }

        var leftIndex = cleanedString.startIndex
        var rightIndex = cleanedString.index(before: cleanedString.endIndex)

        while leftIndex < rightIndex {
            if cleanedString[leftIndex] != cleanedString[rightIndex] {
                return false
            }
            leftIndex = cleanedString.index(after: leftIndex)
            rightIndex = cleanedString.index(before: rightIndex)
        }
        return true
    }

    static func areReverseOfEachOther(_ first: String, _ second: String) -> Bool {
    let cleanedString1 = first.lowercased().filter { $0.isLetter || $0.isNumber }
    let cleanedString2 = second.lowercased().filter { $0.isLetter || $0.isNumber }

    if cleanedString1.count != cleanedString2.count {
        return false
    }

    var leftIndex = cleanedString1.startIndex
    var rightIndex = cleanedString1.index(before: cleanedString1.endIndex)

    while leftIndex < rightIndex {
        if cleanedString1[leftIndex] != cleanedString2[rightIndex] {
            return false
        }
        leftIndex = cleanedString1.index(after: leftIndex)
        rightIndex = cleanedString2.index(before: rightIndex)
    }
    return true
    }
    
}



