enum Question07 {
    static func run() {
        let numbers = Array(1...100)

        let numbersString = fizzBuzz(array: numbers, fizz: 3, buzz: 5)

        for n in 1...20 {
            print(numbersString[n-1])        
            }
    }   

    static func fizzBuzz(array: [Int], fizz: Int, buzz: Int) -> [String] {
        var result: [String] = []
        result.reserveCapacity(array.count)

        for i in array {

            let multipleOfFizz = i % fizz == 0
            let multipleOfBuzz = i % buzz == 0

            if multipleOfFizz && multipleOfBuzz {
                result.append("FizzBuzz")
            } else if multipleOfFizz {
                result.append("Fizz")
            } else if multipleOfBuzz {
                result.append("Buzz")
            } else {
                result.append(String(i))
            }
        }

        return result
    }


}
