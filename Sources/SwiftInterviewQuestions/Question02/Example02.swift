enum Question02 {
    static func run() {
        print("This is Question 02 - Example.")        

        var map = Array(repeating: Array(repeating: 1, count: 15), count: 13)
        // Example rectangles
        clearRectangle(in: &map, startRow: 1, startColumn: 1, height: 5, width: 2)
        clearRectangle(in: &map, startRow: 4, startColumn: 5, height: 3, width: 5)
        clearRectangle(in: &map, startRow: 9, startColumn: 2, height: 4, width: 10)

        var comp = complement(of: map)

        print("  ")
        printMatrix(map)

        print(" ")
        let rectangles = findRectanglesEfficiently(in: comp)

        for point in rectangles {
            printRectangleCorners(point)
        }
    }

}