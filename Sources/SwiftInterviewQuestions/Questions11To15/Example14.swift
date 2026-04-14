enum Question14 {
    static func run() {
        let numbers = Array(1...100)

        let numbersString = fizzBuzz(array: numbers, fizz: 3, buzz: 5)

        for n in 20...40 {
            print(numbersString[n-1])        
        }
    }   

    static func fizzBuzz(array: [Int], fizz: Int, buzz: Int) -> [String] {
        var result: [String] = []
        result.reserveCapacity(array.count)

        for i in array {
            result.append(stringFizzBuzz(number: i, fizz: fizz, buzz: buzz))
        }

        return result
    }

    static func stringFizzBuzz(number: Int, fizz: Int, buzz: Int) -> String {
        let stringNumber = String(number)
        let result: String = stringNumber.replacingOccurrences(of: String(fizz), with: "Fizz")
                                        .replacingOccurrences(of: String(buzz), with: "Buzz")
        return result.isEmpty ? stringNumber : result     
    }

}
