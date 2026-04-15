enum Question09 {
    static func run() {
        let input1 = "Dormitory"
        let input2 = "Dirty Room"
        print("Inputs: \"\(input1)\" and \"\(input2)\"")
        print(areAnagrams(input1, input2) ? "Are anagrams" : "Are not anagrams")     
    }

    static func countCharacters(_ input: String) -> [Character: Int] {
        var characterCount: [Character: Int] = [:]

        input.forEach { char in
            characterCount[char, default: 0] += 1
        }

        return characterCount
    }

    static func areAnagrams(_ first: String, _ second: String) -> Bool {
        let cleanedString1 = first.lowercased().filter { $0.isLetter || $0.isNumber }
        let cleanedString2 = second.lowercased().filter { $0.isLetter || $0.isNumber }

        guard cleanedString1.count == cleanedString2.count else {
            return false
        }

        var characterCount1 = countCharacters(cleanedString1)

   
        for char in cleanedString2 {       
            guard let count = characterCount1[char], count > 0 else {
                return false
            }
            characterCount1[char] = count - 1
            
        }

        //If we reach this point, all characters in cleanedString2 have been accounted for in characterCount1
        // We can also check if all counts in characterCount1 are zero, but since we already checked the lengths and decremented counts, this is not necessary.
 
        return true
    }
    
}



