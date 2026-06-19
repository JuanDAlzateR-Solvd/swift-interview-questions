enum Question03v5: InterviewQuestion {
    static func run() {

        //Version 5: Using two stacks to decode the string iteratively.

        //Code ready to run in one compiler:

        //RUN CODE

        let input = "start2[b3[cd]middle5[f]]end"
        print("EncodedString: \(input)")
        let result = decodeString(input)
        print("DecodedString: \(result)")

        func decodeString(_ string: String) -> String {
            var stringStack: [String] = []
            var countStack: [Int] = []

            var number = 0
            var currentString = ""

            for s in string {
                let str = String(s)

                if let digit = Int(str) {
                    number = 10 * number + digit
                } else if str == "[" {

                    countStack.append(number)
                    stringStack.append(currentString)

                    number = 0
                    currentString = ""

                } else if str == "]" {

                    if let previousString = stringStack.popLast(), let count = countStack.popLast()
                    {
                        currentString =
                            previousString + String(repeating: currentString, count: count)
                    }

                } else {
                    currentString += str
                }
            }

            return currentString
        }

    }

}
