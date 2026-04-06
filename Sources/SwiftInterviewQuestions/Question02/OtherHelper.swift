import Foundation



struct MatrixCoordinate: CustomStringConvertible {
    let row: Int
    let column: Int

    var description: String {
        "(\(row), \(column))"
    }
}

struct MatrixRectangle: CustomStringConvertible {
    let topLeft: MatrixCoordinate
    let bottomRight: MatrixCoordinate

    var width: Int {
        bottomRight.column - topLeft.column + 1
    }

    var height: Int {
        bottomRight.row - topLeft.row + 1
    }

    var cgRect: CGRect {
        CGRect(
            x: topLeft.column,
            y: topLeft.row,
            width: width,
            height: height
        )
    }

    var description: String {
        "topLeft: \(topLeft), bottomRight: \(bottomRight)"
    }
}



func columnSums(in matrix: [[Int]]) -> [Int] {
    guard let firstRow = matrix.first else { return [] }

    var sums = Array(repeating: 0, count: firstRow.count)

    for row in matrix {
        for (index, value) in row.enumerated() {
            sums[index] += value
        }
    }

    return sums
}

func rowSums(in matrix: [[Int]]) -> [Int] {
    matrix.map { $0.reduce(0, +) }
}

func firstIndex(
    in array: [Int],
    startingAt startIndex: Int,
    where predicate: (Int) -> Bool
) -> Int? {
    guard startIndex >= 0, startIndex < array.count else { return nil }
    return array[startIndex...].firstIndex(where: predicate)
}

func lastIndex(
    in array: [Int],
    startingAt startIndex: Int,
    where predicate: (Int) -> Bool
) -> Int? {
    guard startIndex >= 0, startIndex < array.count else { return nil }
    return array[startIndex...].lastIndex(where: predicate)
}

func firstNonZeroIndex(in array: [Int], startingAt startIndex: Int = 0) -> Int? {
    firstIndex(in: array, startingAt: startIndex) { $0 != 0 }
}

func firstZeroIndex(in array: [Int], startingAt startIndex: Int = 0) -> Int? {
    firstIndex(in: array, startingAt: startIndex) { $0 == 0 }
}

func firstOneIndex(in array: [Int], startingAt startIndex: Int = 0) -> Int? {
    firstIndex(in: array, startingAt: startIndex) { $0 == 1 }
}

func lastOneIndex(in array: [Int], startingAt startIndex: Int = 0) -> Int? {
    lastIndex(in: array, startingAt: startIndex) { $0 == 1 }
}

func printMatrixWithSums(_ matrix: [[Int]]) {
    print("Matrix with row and column sums")

    for row in matrix {
        let content = row.map { "\($0)" }.joined(separator: "\t")
        let rowSum = row.reduce(0, +)
        print("[\(content)] : \(rowSum)")
    }

    let sums = columnSums(in: matrix)
    let separator = " " + sums.map { _ in "-" }.joined(separator: "\t") + " "
    print(separator)

    let sumsLine = sums.map { "\($0)" }.joined(separator: "\t")
    print("[\(sumsLine)] : \(sums.reduce(0, +))")
}

func boundingRectangle(in matrix: [[Int]]) -> MatrixRectangle? {
    let columns = columnSums(in: matrix)
    let rows = rowSums(in: matrix)

    guard let leftColumn = firstNonZeroIndex(in: columns),
          let topRow = firstNonZeroIndex(in: rows)
    else {
        return nil
    }

    let remainingColumns = Array(columns[leftColumn...])
    let remainingRows = Array(rows[topRow...])

    let firstZeroColumnOffset = firstZeroIndex(in: remainingColumns) ?? remainingColumns.count
    let firstZeroRowOffset = firstZeroIndex(in: remainingRows) ?? remainingRows.count

    let rightColumn = leftColumn + firstZeroColumnOffset - 1
    let bottomRow = topRow + firstZeroRowOffset - 1

    return MatrixRectangle(
        topLeft: MatrixCoordinate(row: topRow, column: leftColumn),
        bottomRight: MatrixCoordinate(row: bottomRow, column: rightColumn)
    )
}

func submatrix(
    of matrix: [[Int]],
    fromRow startRow: Int,
    fromColumn startColumn: Int
) -> [[Int]] {
    guard startRow >= 0,
          startColumn >= 0,
          startRow < matrix.count,
          startColumn < (matrix.first?.count ?? 0)
    else {
        return []
    }

    return matrix[startRow...].map { Array($0[startColumn...]) }
}

func contains(_ coordinate: MatrixCoordinate, in matrix: [[Int]]) -> Bool {
    coordinate.row >= 0 &&
    coordinate.column >= 0 &&
    coordinate.row < matrix.count &&
    coordinate.column < (matrix.first?.count ?? 0)
}

func firstFilledCoordinate(in matrix: [[Int]]) -> MatrixCoordinate? {
    let columnTotals = columnSums(in: matrix)
    let rowTotals = rowSums(in: matrix)

    guard let column = firstNonZeroIndex(in: columnTotals),
          let row = firstNonZeroIndex(in: rowTotals)
    else {
        return nil
    }

    return MatrixCoordinate(row: row, column: column)
}

func column(at index: Int, in matrix: [[Int]]) -> [Int] {
    matrix.map { $0[index] }
}

func rectangleBottomRight(
    in matrix: [[Int]],
    startingAt start: MatrixCoordinate
) -> MatrixCoordinate? {
    guard contains(start, in: matrix) else { return nil }

    let row = matrix[start.row]
    let columnValues = column(at: start.column, in: matrix)

    let rightBoundary = (firstZeroIndex(in: row, startingAt: start.column).map { $0 - 1 })
        ?? lastOneIndex(in: row, startingAt: start.column)

    let bottomBoundary = (firstZeroIndex(in: columnValues, startingAt: start.row).map { $0 - 1 })
        ?? lastOneIndex(in: columnValues, startingAt: start.row)

    guard let bottomRow = bottomBoundary,
          let rightColumn = rightBoundary
    else {
        return nil
    }

    return MatrixCoordinate(row: bottomRow, column: rightColumn)
}

func clearRectangle(
    in matrix: inout [[Int]],
    from topLeft: MatrixCoordinate,
    to bottomRight: MatrixCoordinate
) {
    let height = bottomRight.row - topLeft.row + 1
    let width = bottomRight.column - topLeft.column + 1

    clearRectangle(
        in: &matrix,
        startRow: topLeft.row,
        startColumn: topLeft.column,
        height: height,
        width: width
    )
}

func findRectanglesByRemoval(in matrix: [[Int]]) -> [MatrixRectangle] {
    var workingMatrix = complement(of: matrix)
    var rectangles: [MatrixRectangle] = []

    while let start = firstFilledCoordinate(in: workingMatrix),
          let end = rectangleBottomRight(in: workingMatrix, startingAt: start) {
        let rectangle = MatrixRectangle(topLeft: start, bottomRight: end)
        rectangles.append(rectangle)
        clearRectangle(in: &workingMatrix, from: start, to: end)
    }

    return rectangles
}

