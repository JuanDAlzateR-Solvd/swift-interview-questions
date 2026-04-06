import Foundation
import CoreGraphics

func clearRectangle(
    in matrix: inout [[Int]],
    startRow: Int,
    startColumn: Int,
    height: Int,
    width: Int
) {
    let rowCount = matrix.count
    let columnCount = matrix.first?.count ?? 0

    guard startRow >= 0,
          startColumn >= 0,
          startRow < rowCount,
          startColumn < columnCount,
          height > 0,
          width > 0
    else {
        return
    }

    let endRow = min(startRow + height, rowCount)
    let endColumn = min(startColumn + width, columnCount)

    for row in startRow..<endRow {
        for column in startColumn..<endColumn {
            matrix[row][column] = 0
        }
    }
}

func printRectangleCorners(_ rect: CGRect) {
    let topLeft: (r: Int, c: Int) = (Int(rect.minY), Int(rect.minX))
    let bottomRight: (r: Int, c: Int) = (Int(rect.maxY), Int(rect.maxX))

    print("Top-left: (\(topLeft.r), \(topLeft.c))   Bottom-right: (\(bottomRight.r), \(bottomRight.c))")
}

func complement(of matrix: [[Int]]) -> [[Int]] {
    matrix.map { row in
        row.map { $0 == 0 ? 1 : 0 }
    }
}

func printMatrix<T>(_ matrix: [[T]]) {
    for row in matrix {
        let line = "[" + row.map { "\($0)" }.joined(separator: "\t") + "]"
        print(line)
    }
}

// Best solution when rectangles are guaranteed not to be adjacent
func findRectanglesEfficiently(in matrix: [[Int]]) -> [CGRect] {
    var rectangles: [CGRect] = []

    let rowCount = matrix.count
    let columnCount = matrix.first?.count ?? 0

    for row in 0..<rowCount {
        for column in 0..<columnCount {
            guard matrix[row][column] == 1 else { continue }

            let hasOneAbove = row > 0 && matrix[row - 1][column] == 1
            let hasOneOnLeft = column > 0 && matrix[row][column - 1] == 1

            guard !hasOneAbove && !hasOneOnLeft else { continue }

            var width = 0
            while column + width < columnCount && matrix[row][column + width] == 1 {
                width += 1
            }

            var height = 0
            while row + height < rowCount && matrix[row + height][column] == 1 {
                height += 1
            }

            rectangles.append(CGRect(x: column, y: row, width: width, height: height))
        }
    }

    return rectangles
}

