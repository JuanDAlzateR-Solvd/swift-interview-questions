enum Question02 {
    static func run() {
        print("This is Question 02 - Example No adjacent rectangles.")        

        var map = Array(repeating: Array(repeating: 1, count: 15), count: 13)
        // Example rectangles
        clearRectangle(in: &map, startRow: 1, startColumn: 1, height: 5, width: 2)     
        clearRectangle(in: &map, startRow: 4, startColumn: 5, height: 3, width: 5)
        clearRectangle(in: &map, startRow: 9, startColumn: 2, height: 4, width: 10)

        var comp = complement(of: map)

        print("  ")
        printMatrix(map)

        print(" ")
        var rectangles = findRectanglesEfficiently(in: comp)  

        for point in rectangles {
            printRectangleCorners(point)
        }

        // print("  ")
        // print("This is Question 02 - Example adjacent rectangles.")        

        // map = Array(repeating: Array(repeating: 1, count: 15), count: 13)
        // // Example rectangles
        // clearRectangle(in: &map, startRow: 1, startColumn: 1, height: 5, width: 2)
        // clearRectangle(in: &map, startRow: 2, startColumn: 3, height: 2, width: 4)
        // clearRectangle(in: &map, startRow: 4, startColumn: 5, height: 3, width: 5)
        // clearRectangle(in: &map, startRow: 9, startColumn: 2, height: 4, width: 10)
        // clearRectangle(in: &map, startRow: 7, startColumn: 8, height: 2, width: 2)

        // comp = complement(of: map)

        // print("  ")
        // printMatrix(map)

        // print(" ")

        // rectangles = findRectanglesRobust(in: &comp)

        // for point in rectangles {
        //     printRectangleCorners(point)
        // }

        print("  ")
        print("This is Question 02 - Example adjacent rectangles - travel frontier.")        

        map = Array(repeating: Array(repeating: 1, count: 15), count: 13)
        // Example rectangles
        clearRectangle(in: &map, startRow: 1, startColumn: 1, height: 5, width: 2)
        clearRectangle(in: &map, startRow: 2, startColumn: 3, height: 2, width: 4)
        clearRectangle(in: &map, startRow: 4, startColumn: 5, height: 3, width: 5)
        clearRectangle(in: &map, startRow: 9, startColumn: 2, height: 4, width: 10)
        clearRectangle(in: &map, startRow: 7, startColumn: 8, height: 2, width: 2)

        comp = complement(of: map)

        print("  ")
        printMatrix(comp)
        print(" ")

        rectangles = findRectanglesFrontier(in: &comp)  

        for point in rectangles {
            printRectangleCorners(point)
        }

    }

}