enum Question10v2: InterviewQuestion {
    static func run() {
        let input = "a{b(23)[]()}[()]"
            let result = validBrackets(input)
            print("Input: \(input)")
            print("Result: \(result)")
        }
         
        static let brackets: [Character:Character] = ["(":")","{":"}","[":"]"]
        static let openingBrackets = Set(brackets.keys)
        static let closingBrackets = Set(brackets.values)
        
        static func validBrackets(_ str:String) -> Bool {
        
        var stack: [Character] = []
        
        for char in str{
        
        if (openingBrackets.contains(char)){
            stack.append(char)
        }else if (closingBrackets.contains(char)){
            guard let last = stack.last, let pair = brackets[last] else {
            return false
            }
        
            if (pair == char){
            stack.removeLast()
            }else{
            return false
            }
        }
        }
        return stack.isEmpty
        
        }  

}