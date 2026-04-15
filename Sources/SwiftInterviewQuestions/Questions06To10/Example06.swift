enum Question06 {
    static func run() {
        let coins = 400
        let menu = [
            "coffee": 100,
            "cake": 200,
            "popcorn": 225  
        ]

        let cheapestItem = menu.min { $0.value < $1.value }?.key ?? "No items"
        print("Cheapest item: \(cheapestItem)")

        let maxItems = calculateMaxAmountOfItems(item: cheapestItem, coins: coins, menu: menu)
        print("Maximum items that can be bought: \(maxItems.numberOfItems), Change: \(maxItems.change)")

    }

    static func calculateMaxAmountOfItems(item: String, coins: Int, menu: [String: Int]) -> (change: Int, numberOfItems: Int) {
        let price = menu[item] ?? 0
        if price == 0 {
            return (change: coins, numberOfItems: 0)
        }
        let numberOfItems = coins / price
        let change = coins % price
        return (change: change, numberOfItems: numberOfItems)
    }

}
