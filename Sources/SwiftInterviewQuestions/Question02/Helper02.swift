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
    // print("cleared rectangle from (\(startRow), \(startColumn)) to (\(endRow - 1), \(endColumn - 1))")
}

func printRectangleCorners(_ rect: CGRect) {
    let topLeft: (r: Int, c: Int) = (Int(rect.minY), Int(rect.minX))
    let bottomRight: (r: Int, c: Int) = (Int(rect.maxY), Int(rect.maxX))

    print("Top-left: (\(topLeft.r), \(topLeft.c))   Bottom-right: (\(bottomRight.r - 1), \(bottomRight.c - 1))")
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

// More robust solution when rectangles are not guaranteed not to be adjacent
//It could be improven
func findRectanglesRobust(in matrix: inout [[Int]]) -> [CGRect] {
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

            var diagonalX: Int = 0
            var diagonalY: Int = 0
            var coordinates: [MatrixCoordinate] = []     
            repeat {
                (diagonalX, diagonalY) = calculateNext(width: width, height: height, x: diagonalX, y: diagonalY, coordinates: &coordinates)
            } while ((diagonalX != 0 || diagonalY != 0)  && matrix[row + diagonalX][column + diagonalY] == 1)

            // width = min(width, diagonal)
            // height = min(height, diagonal)

            rectangles.append(CGRect(x: column, y: row, width: width, height: height))
            clearRectangle(in: &matrix, startRow: row, startColumn: column, height: height, width: width)      
        }
               
    }
    
    return rectangles
}

func calculateNext(width: Int, height: Int, x: Int, y: Int, coordinates: inout [MatrixCoordinate]) -> (x: Int, y: Int) {
    let nextX = (x + 1)%width
    let nextY = (y + 1)%height
    //Store frontier coordinates
    if (nextX==0 || nextY==0)  {
        coordinates.append(MatrixCoordinate(row: y, column: x))        
    }
    return (nextX, nextY)
}

//new aproach: travel to the frontier of the polygon and store the coordinates of the corners. (to implement)

func findRectanglesFrontier(in matrix: inout [[Int]]) -> [CGRect] {
    var rectangles: [CGRect] = []

    let rowCount = matrix.count
    let columnCount = matrix.first?.count ?? 0

    for row in 0..<rowCount {
        for column in 0..<columnCount {
            guard matrix[row][column] == 1 else { continue }

            let hasOneAbove = row > 0 && matrix[row - 1][column] == 1
            let hasOneOnLeft = column > 0 && matrix[row][column - 1] == 1

            guard !hasOneAbove && !hasOneOnLeft else { continue }

            var frontierMatrix = Matrix(matrix: matrix, size: MatrixCoordinate(row: matrix.count, column: matrix.first?.count ?? 0))

            var corners: [MatrixCoordinate] = frontierMatrix.travelFrontier(from: MatrixCoordinate(row: row, column: column))

            for corner in corners {
                // print("Corner at (\(corner.row), \(corner.column))")
            }

            var maxX = corners.map { $0.column }.max() ?? 0
            var maxY = corners.map { $0.row }.max() ?? 0

            let width = maxX - column + 1
            let height = maxY - row + 1
            // print("Starting at (\(row), \(column)) with width: \(width) and height: \(height)")
            rectangles.append(CGRect(x: column, y: row, width: width, height: height))
            clearRectangle(in: &matrix, startRow: row, startColumn: column, height: height, width: width)      
        }
               
    }
    
    return rectangles
}



