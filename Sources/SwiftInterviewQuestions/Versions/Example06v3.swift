enum Question06v3: InterviewQuestion {
    static func run() {
        let coins = 400

        let menuItem0 = MenuItem(id: 0, name: "coffee", price: 100)
        let menuItem1 = MenuItem(id: 1, name: "cake", price: 200)
        let menuItem2 = MenuItem(id: 2, name: "popcorn", price: 225)
        let menu = [menuItem0, menuItem1, menuItem2]
        var map = initiliazeMap(intialMoney: coins, menu: menu)

        print("Items: \(menu.map({ $0.name }))")
   
        var i=0

        while let node = map[[i,0,0]], node.change >= menu[0].price {
             expandMap(map: &map, menu: menu)
             i += 1
        }
        printMap(map:map, maxNumberOfItems: i)
    }

    static func printMap(map: [[Int]: Node], maxNumberOfItems: Int) {
        for i in 0...maxNumberOfItems{
            var string = "\nNumber of items: \(i)"
            for (key, value) in map.filter({ $0.value.numberOfItems == i && $0.value.change >= 0 }) {
                string += "\n\tItems: \(key), Change: \(value.change) "           
            }
            print(string)
        }
    }

    static func printFullMap(_ map: [[Int]: Node], maxNumberOfItems: Int) {
        for i in 0...maxNumberOfItems{
            var string = "\nNumber of items: \(i)"
            for (key, value) in map.filter({ $0.value.numberOfItems == i }) {
                string += "\n\tItems: \(key), Change: \(value.change) "           
            }
            print(string)
        }
    }

    struct MenuItem: Hashable {
        let id: Int
        let name: String
        let price: Int

        init(id: Int, name: String, price: Int) {
            self.id = id
            self.name = name
            self.price = price
        }
    }

    struct Node: Hashable {   
        let change: Int
        let numberOfItems: Int

        init(numberOfItems: Int = 0, change: Int = 0) {
            self.change = change
            self.numberOfItems = numberOfItems
        }
    }

    static func initiliazeMap(intialMoney: Int, menu: [MenuItem]) -> [[Int]: Node] {
        let n = menu.count
        var map: [[Int]: Node] = [:]
        let origin = Array(repeating: 0, count: 3)
        map[origin] = Node(numberOfItems: 0, change: intialMoney)
        
        return map
    }

    static func expandFloor(map: inout [[Int]: Node], floorZ: Int, menu: [MenuItem])  {
        let root = [0,0,floorZ]
        guard let rootNode = map[root] else {
            print("Error: Root node not found in map for coordinate \(root)")
            return
        }
        var node = rootNode
        var array = root
        while let nextNode = map[array] {
            node = nextNode
            array[0] += 1            
        }
        array[0] -= 1  
        debugPrintArray(message: "maxXNode", array: array)
        array[0] += 1  

        let newNumberOfItems = node.numberOfItems + 1
        map[array] = Node(numberOfItems: newNumberOfItems, change: node.change - menu[0].price)
        let i=0
        var oldArray = array
        var newArray = array
        let n = menu.count
        let priceChange = menu[0].price - menu[1].price

        debugPrintArray(message: "new array", array: newArray)
        for i in 0..<newNumberOfItems-floorZ{
            newArray[0] = oldArray[0]-1
            newArray[1] = oldArray[1]+1
            debugPrintArray(message: "new array", array: newArray)
            map[newArray] = Node(numberOfItems: newNumberOfItems, change: map[oldArray]!.change + priceChange)
            oldArray = newArray
        }
    }

    static func expandMap(map: inout [[Int]: Node], menu: [MenuItem]) {
        let root = [0,0,0]
        guard let rootNode = map[root] else {
            print("Error: Root node not found in map for coordinate \(root)")
            return
        }
        var node = rootNode
        var array = root
        while let nextNode = map[array] {
            node = nextNode
            array[2] += 1            
        }
        let numberOfFloors = array[2] 

        for i in 0..<numberOfFloors {
            debugPrint("\n Expanding floor \(i)")
            expandFloor(map: &map, floorZ: i, menu: menu)
            debugPrintFloor(map: map, floorZ: i)
            debugPrint("Finished expanding floor \(i) \n ")
        }
    
        map[array] = Node(numberOfItems: node.numberOfItems+1, change: node.change - menu[2].price)
    }

    static func debugPrintArray(message: String, array: [Int]) {
        debugPrint("\(message): \(array)")
    }

    static func debugPrintFloor(map: [[Int]: Node], floorZ: Int) {
        // print("Floor \(floorZ): \(map.keys.filter({ $0[2] == floorZ }))")       
    }

    static func debugPrint(_ message: String) {
        // print(message)
    }
}
