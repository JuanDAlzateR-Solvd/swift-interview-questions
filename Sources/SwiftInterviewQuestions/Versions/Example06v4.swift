enum Question06v4: InterviewQuestion {

    //Solution from interview
    //This is what I came up with during the interview. 
    //I'll leave the code as it is, Question06v5 is the improved version of this code.

    static func run() {
        let coins = 400

        let itemX = Item(name: "coffee", price: 100)
        let itemY = Item(name: "cake", price: 200)
        let itemZ = Item(name: "popcorn", price: 225)

        var array = calculate(item: itemZ, change: 400)
        var array2 = calculate2(array: array, item: itemY)
        var array3 = calculate3(array: array2, item: itemX)

        print("all combinations")
        for comb in array3 {
            comb.printComb()
        }

    }

    struct Item {
        var name: String
        var price: Int
    }

    class Combination {
        var x: Int
        var y: Int
        var z: Int
        var change: Int = 0
        var numberOfItems: Int = 0

        init(_ array: [Int]) {
            x = array[0]
            y = array[1]
            z = array[2]
        }

        func updateCombination(_ change: Int) {
            self.change = change
            numberOfItems = x + y + z
        }

        func printComb() {
            print("(\(x),\(y),\(z)) change:\(change)")
        }

    }

    static func calculate(item: Item, change: Int) -> [Combination] {
        let price = item.price
        let n = change / price
        var newCombinations: [Combination] = []

        for i in 0...n {
            var comb = Combination([0, 0, i])
            comb.updateCombination(change - price * i)
            // comb.printComb()
            newCombinations.append(comb)
        }
        return newCombinations
    }

    static func updateY(item: Item, combination: Combination) -> [Combination] {
        let price = item.price
        let n = combination.change / price

        var newCombinations: [Combination] = []

        for i in 0...n {
            var comb = Combination([0, i, combination.z])
            comb.updateCombination(combination.change - price * i)
            // comb.printComb()
            newCombinations.append(comb)
        }
        return newCombinations
    }

    static func calculate2(array: [Combination], item: Item) -> [Combination] {
        let price = item.price
        // let n = change/price

        var newCombinations: [Combination] = []
        for comb in array {
            newCombinations.append(contentsOf: updateY(item: item, combination: comb))
        }
        return newCombinations
    }

    static func updateX(item: Item, combination: Combination) -> [Combination] {
        let price = item.price
        let n = combination.change / price

        var newCombinations: [Combination] = []

        for i in 0...n {
            var comb = Combination([i, combination.y, combination.z])
            comb.updateCombination(combination.change - price * i)
            // comb.printComb()
            newCombinations.append(comb)
        }
        return newCombinations
    }

    static func calculate3(array: [Combination], item: Item) -> [Combination] {
        let price = item.price
        // let n = change/price

        var newCombinations: [Combination] = []
        for comb in array {
            newCombinations.append(contentsOf: updateX(item: item, combination: comb))
        }
        return newCombinations
    }

}
