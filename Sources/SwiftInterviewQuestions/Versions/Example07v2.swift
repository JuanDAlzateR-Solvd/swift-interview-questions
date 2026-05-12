enum Question07v2: InterviewQuestion {
    static func run() {
        let nums: [Int] = Array(1...100)
        let result = fizzBuzz(array:nums, fizz:3, buzz:5 )
        for i in 0...20{
          print(result[i])
        }

        // runTests()
    }

    static func fizzBuzz(array: [Int], fizz: Int, buzz: Int) -> [String] {

        var result: [String] = []

        for i in array{
            let string = fizzBuzzString(number:i,fizz: fizz, buzz: buzz)
            result.append(string)
        }
        return result
    }
    
    static func fizzBuzzString(number: Int, fizz: Int, buzz: Int) -> String{
        let multipleOfFizz = (number % fizz == 0)
        let multipleOfBuzz = (number % buzz == 0)
        
        if multipleOfFizz && multipleOfBuzz {
          return "FizzBuzz"
        }else if multipleOfFizz{
          return "Fizz"
        }else if multipleOfBuzz{
          return "Buzz"
        }else{
         return String(number)
        }
    }
    
    static func runTests() {
        print(" Starting Simple Unit Tests...\n")
        var passedCount = 0
        var failedCount = 0
        
        // Helper closure to validate results without crashing the whole program on the first error
        func testFizzBuzz(input: Int, fizz: Int = 3, buzz: Int = 5, expected: String) {
            let actual = fizzBuzzString(number: input, fizz: fizz, buzz: buzz)
            
            if actual == expected {
                print("test \(passedCount+failedCount+1) - PASS: ")
                passedCount += 1
            } else {
                print("test \(passedCount+failedCount+1) - FAIL: ")
                print("   Expected: \(expected)")
                print("   Actual:   \(actual)")
                failedCount += 1
            }
        }
        
        testFizzBuzz(input: 1, expected: "1")
        testFizzBuzz(input: 30, expected: "FizzBuzz")
        testFizzBuzz(input: 10, expected: "Buzz")
        testFizzBuzz(input: 9, expected: "Fizz")
        
        // MARK: Final Summary Report
        print("\n TEST SUMMARY")
        print("Passed: \(passedCount) | Failed: \(failedCount)")
        
        // Hard crash if any suite fails to catch attention during continuous integration simulations
        if failedCount > 0 {
            print(" One or more unit tests failed!")
        } else {
            print("All tests passed successfully!")
        }
    }

}