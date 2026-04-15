import Foundation

struct MatrixCoordinate: CustomStringConvertible, Hashable {
    let row: Int
    let column: Int

    var description: String {
        "(\(row), \(column))"
    }
}

struct Matrix {
    let matrix: [[Int]]
    let size: MatrixCoordinate  

    func travelRight(from coordinate: MatrixCoordinate) -> MatrixCoordinate {
        var deltaX = 0    
        let row = coordinate.row
        let column = coordinate.column  
        let columnSize = size.column

        while column + deltaX < columnSize && matrix[row][column + deltaX] == 1 {
                    deltaX += 1
                }

        return MatrixCoordinate(row: row, column: column + deltaX - 1)
    }
    
    func travelLeft(from coordinate: MatrixCoordinate) -> MatrixCoordinate {
        var deltaX = 0    
        let row = coordinate.row
        let column = coordinate.column  
        
        while column + deltaX >= 0 && matrix[row][column + deltaX] == 1 {
                    deltaX -= 1
                }

        return MatrixCoordinate(row: row , column: column + deltaX + 1)
    
    }

    func travelDown(from coordinate: MatrixCoordinate) -> MatrixCoordinate {
        var deltaY = 0    
        let row = coordinate.row
        let column = coordinate.column  
        let rowSize = size.row

        while row + deltaY < rowSize && matrix[row + deltaY][column] == 1 {
                    deltaY += 1
                }

        return MatrixCoordinate(row: row + deltaY - 1, column: column)
    }

    func travelUp(from coordinate: MatrixCoordinate) -> MatrixCoordinate {
        var deltaY = 0    
        let row = coordinate.row
        let column = coordinate.column  
        
        while row + deltaY >= 0 && matrix[row + deltaY][column] == 1 {
                    deltaY -= 1
                }

        return MatrixCoordinate(row: row + deltaY + 1, column: column)
    
    }

    func travelStraight(from coordinate: MatrixCoordinate, direction: String) -> MatrixCoordinate {
        switch direction {
        case "right":
            return travelRight(from: coordinate)
        case "left":
            return travelLeft(from: coordinate)
        case "down":
            return travelDown(from: coordinate)
        case "up":
            return travelUp(from: coordinate)
        default:
            fatalError("Invalid direction")
        }
    }

    func travel(from coordinate: MatrixCoordinate, direction lastMoveDirection:  inout String) -> MatrixCoordinate {
        let newDirection = calculateNewDirection(from: coordinate, lastDirection: lastMoveDirection)      
        let newCoordinate = travelStraight(from: coordinate, direction: newDirection)
        lastMoveDirection = newDirection
        return newCoordinate
    }

    func calculateNewDirection(from coordinate: MatrixCoordinate, lastDirection direction: String) -> String {     
        switch direction {
        case "right":
            return canTravelDown(from: coordinate) ? "down" : "up"
        case "down":
            return canTravelLeft(from: coordinate) ? "left" : "right"
        case "left":
            return canTravelUp(from: coordinate) ? "up" : "down"
        case "up":
            return canTravelRight(from: coordinate) ? "right" : "left"
        default:
            fatalError("Invalid direction")
        }
    }

    func canTravelLeft(from coordinate: MatrixCoordinate) -> Bool {
        let column = coordinate.column - 1
        if column < 0 {
            return false
        } else {
            return matrix[coordinate.row][column] == 1
        }
    }

    func canTravelRight(from coordinate: MatrixCoordinate) -> Bool {
        let column = coordinate.column + 1
        if column >= size.column {
            return false
        } else {
            return matrix[coordinate.row][column] == 1
        }
    }

    func canTravelUp(from coordinate: MatrixCoordinate) -> Bool {
        let row = coordinate.row - 1
        if row < 0 {
            return false
        } else {
            return matrix[row][coordinate.column] == 1
        }
    }

    func canTravelDown(from coordinate: MatrixCoordinate) -> Bool {
        let row = coordinate.row + 1
        if row >= size.row {
            return false
        } else {
            return matrix[row][coordinate.column] == 1
        }
    }

    func travelFrontier(from coordinate: MatrixCoordinate) -> [MatrixCoordinate] {
        var frontierCoordinates: [MatrixCoordinate] = [coordinate]

        var nextCoordinate = travelDown(from: coordinate)        
        var lastMoveDirection: String = "down"
        
        var turn = 0
        while !frontierCoordinates.contains(nextCoordinate) && turn < 100 {            
            frontierCoordinates.append(nextCoordinate)
            nextCoordinate = travel(from: nextCoordinate, direction: &lastMoveDirection)           
            // print("Next coordinate: \(nextCoordinate), last move direction: \(lastMoveDirection)")
            turn += 1
        }

        return frontierCoordinates
    }

}