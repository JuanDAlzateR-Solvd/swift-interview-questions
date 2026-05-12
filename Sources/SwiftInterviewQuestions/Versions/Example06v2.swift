enum Question06v2: InterviewQuestion {
    static func run() {
        let coins = 400
        let menu = [
            "coffee": 100,
            "cake": 200,
            "popcorn": 225  
        ]
    }

    class MenuItem: Hashable, Equatable {
        let name: String
        let price: Int

        init(name: String, price: Int) {
            self.name = name
            self.price = price
        }

        static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
            return lhs.name == rhs.name 
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(price)
        }
    }

    struct Combination: Equatable, Hashable{
        var items: [MenuItem:Int] = [:]
        var change: Int = 0

        @discardableResult
        mutating func addItem(_ item: MenuItem) -> Bool{
            if change >= item.price {
                items[item, default: 0] += 1
                change -= item.price
                return true
            }
            return false
        }

    }

    class Solution{
        var combinations: Set<Combination>
        var numberOfItems: Int

        init(combinations:Set<Combination>, numberOfItems: Int = 0) {
            self.combinations = combinations
            self.numberOfItems = numberOfItems
        }

        func addCombination(_ combination: Combination) {
            combinations.insert(combination)
        }

        func copy() -> Solution {
            return Solution(combinations: combinations, numberOfItems: numberOfItems)
        }

        func addItemToCombinations(_ item: MenuItem) -> Solution {
            var newSolutions = copy()
            var newCombinations = newSolutions.combinations
            for var combination in newCombinations {
                combination.addItem(item)
                newCombinations.update(with: combination)
            }
            return newSolutions
            
        }
    }

    func calculateCombinations(coins: Int, numberOfItems: Int, menu: [String: Int], solutions: inout [Solution]) {

        if numberOfItems == 0 {
            let combination = Combination(change: coins)
            let solution = Solution(combinations: [Combination(change: coins)])
            var solutions: [Solution] = []
            solutions.append(solution)        
        }else{
                let menuItems = menu.map { MenuItem(name: $0.key, price: $0.value) }
              
                for item in menuItems {

                    var combination = Combination(change: coins)
                    while combination.addItem(item) {
                        if combination.items.values.reduce(0, +) == numberOfItems {
                            let solution = Solution(combinations: [combination], numberOfItems: numberOfItems)
                            solutions.append(solution)
                        }
                    }
                }
        }

        let menuItems = menu.map { MenuItem(name: $0.key, price: $0.value) }
        let sortedMenuItems = menuItems.sorted { $0.price < $1.price }

        var combination = Combination(change: coins)

        for item in sortedMenuItems {
            while combination.addItem(item) {}
        }

        // return combination
    }

}
