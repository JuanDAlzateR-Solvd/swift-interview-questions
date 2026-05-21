enum Question06v5: InterviewQuestion {
    //Improved version of Question06v4. It is more generic and easier to read. It is not optimized.
    // Finished code, it is compatible with n items. It is not optimized.
    //Example with 4 items (1 more than interview)
    
    static func run() {
        //RUN CODE
        let initialMoney = 400
        let coffee = Item(id: 0, name: "coffee", price: 100)
        let cake = Item(id: 1, name: "cake", price: 200)
        let popcorn = Item(id: 2, name: "popcorn", price: 225)
        let water = Item(id: 3, name: "water", price: 50)
        let menu = [coffee, cake, popcorn, water]

        var comb = Combination.generateZeroCombination(menu: menu)
        comb.updateCombination(change: initialMoney)
        var array = [comb]

        var id = 0
        let numberOfItems = menu.count
        for id in (0..<numberOfItems).reversed() {
            let item = menu[id]
            array = calculate(array: array, item: item)
        }

        print("menu")
        for item in menu {
            print("\(item.id). item: \(item.name)   \t price: \(item.price)")
        }

        printAllCombinations(menu: menu, array: array)
        
        //CLASSES, STRUCTS AND FUNCTIONS

        struct Item {
            var id: Int
            var name: String
            var price: Int
        }

        class Combination {
            var quantities: [Int]
            var change: Int = 0
            var numberOfItems: Int = 0

            init(_ array: [Int]) {
                quantities = array
            }

            func updateCombination(change: Int) {
                self.change = change
                numberOfItems = quantities.reduce(0, +)
            }

            func printComb() {
                var str = "("
                for i in quantities {
                    str += "\(i),"
                }

                str = str.dropLast() + ")"
                print(str + " change:\(change)")
            }

            func getDimension() -> Int {
                return quantities.count
            }

            static func generateZeroCombination(menu: [Item]) -> Combination {
                let n = menu.count
                let array = Array(repeating: 0, count: n)
                return Combination(array)
            }

        }

        func calculateNewCombinationsByAddingItem(item: Item, combination: Combination) -> [Combination] {
            let price = item.price
            let n = combination.change / price

            var newCombinations: [Combination] = []

            for i in 0...n {
                var comb = createCombination(i: i, item: item, combination: combination)
                comb.updateCombination(change:combination.change - price * i)
                newCombinations.append(comb)
            }
            return newCombinations
        }

        //Creates a new combination by adding i items of the given item to the given combination
        func createCombination(i: Int, item: Item, combination: Combination) -> Combination {
            var id = item.id

            var array: [Int] = []
            for j in 0..<id {
                array.append(0)
            }
            array.append(i)

            if id + 1 <= combination.getDimension() {
                for j in (id + 1)..<combination.getDimension() {
                    array.append(combination.quantities[j])
                }
            }
            return Combination(array)
        }

        func calculate(array: [Combination], item: Item) -> [Combination] {
            let price = item.price
            var newCombinations: [Combination] = []
            for comb in array {
                newCombinations.append(contentsOf: calculateNewCombinationsByAddingItem(item: item, combination: comb))
            }
            return newCombinations
        }

        func printAllCombinations(menu: [Item], array: [Combination]) {
            print("\n == ALL COMBINATIONS ==")
            var itemsString = "("
            for item in menu {
                itemsString += "\(item.name),"
            }
            itemsString = itemsString.dropLast() + ")"
            print(itemsString)

            for i in 0..<array.count {
                var filteredArray = array.filter({ $0.numberOfItems == i })
                
                guard !filteredArray.isEmpty else {
                    continue
                }
                print("\nNumber of items: \(i)")
                for comb in filteredArray {
                    comb.printComb()
                }
            }
        }
    }

}
