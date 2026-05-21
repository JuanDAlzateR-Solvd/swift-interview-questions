enum Question06v6: InterviewQuestion {
    //Backtrack solution for Question06.

    static func run() {
        let initialMoney = 400

        let coffee = Item(name: "coffee", price: 100)
        let cake = Item(name: "cake", price: 200)
        let popcorn = Item(name: "popcorn", price: 225)

        let menu = [coffee, cake, popcorn]

        solution(initialMoney: initialMoney, menu: menu)
    }

    static func solution(initialMoney: Int, menu: [Item]) {
        var result: [[Int]] = []
        let numberOfItems = menu.count
        let minimumPrice = menu.min { $0.price < $1.price }?.price ?? 1

        func backtrack(index: Int, path: inout [Int]) {

            //base
            if index >= numberOfItems || path[0] < 0 {  //path[0] stores the amount of change
                return
            }
            if path[0] < minimumPrice {
                result.append(path)
                return
            }

            //decision 1
            increaseItemAmmount(index: index, path: &path, menu: menu)
            backtrack(index: index, path: &path)
            decreaseItemAmmount(index: index, path: &path, menu: menu)

            //desicion 2
            backtrack(index: index + 1, path: &path)

        }

        var path: [Int] = [initialMoney]
        var str = "[Change, "
        for i in menu {
            path.append(0)
            str += i.name + ", "
        }

        str.removeLast()
        str.removeLast()
        str += "]"

        print(str)
        backtrack(index: 0, path: &path)

        for i in result {
            print(i)
        }

    }

    static func increaseItemAmmount(index: Int, path: inout [Int], menu: [Item]) {
        path[index + 1] += 1
        path[0] -= menu[index].price
    }
    static func decreaseItemAmmount(index: Int, path: inout [Int], menu: [Item]) {
        path[index + 1] -= 1
        path[0] += menu[index].price
    }

    struct Item {
        let name: String
        let price: Int
    }

}
