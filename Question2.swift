
var miMapa = Array(repeating: Array(repeating: 1, count: 15), count: 13)

func dibujarRectangulo(en matriz: inout [[Int]], f: Int, c: Int, alto: Int, ancho: Int) {
    // 1. Obtenemos los límites máximos reales
    let maxFilas = matriz.count
    let maxCols = matriz.first?.count ?? 0
    
    // 2. Usamos min() para asegurarnos de no pasarnos del borde
    // El rango irá desde el inicio hasta el límite de la matriz o el final del rectángulo
    let finFila = min(f + alto, maxFilas)
    let finCol = min(c + ancho, maxCols)
    
    // 3. Validamos que el punto de inicio sea válido
    guard f >= 0, c >= 0, f < maxFilas, c < maxCols else { return }

    for i in f..<finFila {
        for j in c..<finCol {
            matriz[i][j] = 0
        }
    }
}

// Dibujamos los 3 rectángulos
dibujarRectangulo(en: &miMapa, f: 1, c: 1, alto: 5, ancho: 2)
dibujarRectangulo(en: &miMapa, f: 4, c: 5, alto: 3, ancho: 5)
dibujarRectangulo(en: &miMapa, f: 9, c: 2, alto: 4, ancho: 10)


// imprimir(miMapa)

func sumarColumnas(de matriz: [[Int]]) -> [Int] {
    // Si la matriz está vacía, devolvemos un arreglo vacío
    guard let primeraFila = matriz.first else { return [] }
    
    let conteoColumnas = primeraFila.count
    var sumas = Array(repeating: 0, count: conteoColumnas)

    for fila in matriz {
        for (indice, valor) in fila.enumerated() {
            sumas[indice] += valor
        }
    }

    return sumas
}

func sumarFilas(de matriz: [[Int]]) -> [Int] {
    // map recorre cada fila, y reduce(0, +) suma todos sus elementos
    return matriz.map { fila in 
        fila.reduce(0, +) 
    }
}

func firstNonZero(in array: [Int], startingAt index: Int) -> Int {
    // 1. Validamos que el índice esté dentro del rango
    guard index >= 0 && index < array.count else { return -1 }
    
    // 2. Buscamos el primer 0 desde el índice indicado
    // Usamos el slice array[index...] para buscar solo en esa sección
    return array[index...].firstIndex(where: { $0 != 0 }) ?? -1
}

func firstZero(in array: [Int], startingAt index: Int) -> Int {
    // 1. Validamos que el índice esté dentro del rango
    guard index >= 0 && index < array.count else { return -1 }
    
    // 2. Buscamos el primer 0 desde el índice indicado
    // Usamos el slice array[index...] para buscar solo en esa sección
    return array[index...].firstIndex(where: { $0 == 0 }) ?? -1
}

func firstOne(in array: [Int], startingAt index: Int) -> Int {
    // 1. Validamos que el índice esté dentro del rango
    guard index >= 0 && index < array.count else { return -1 }
    
    // 2. Buscamos el primer 0 desde el índice indicado
    // Usamos el slice array[index...] para buscar solo en esa sección
    return array[index...].firstIndex(where: { $0 == 1 }) ?? -1
}

func lastOne(in array: [Int], startingAt index: Int) -> Int {
    // 1. Validamos que el índice esté dentro del rango
    guard index >= 0 && index < array.count else { return -1 }
    
    // 2. Buscamos el primer 0 desde el índice indicado
    // Usamos el slice array[index...] para buscar solo en esa sección
    return array[index...].lastIndex(where: { $0 == 1 }) ?? -1
}

func imprimir<T>(_ matriz: [[T]]) {
    for fila in matriz {
        // El \t añade un tabulador para que las columnas se alineen
        var linea = "["
        linea = linea + fila.map { "\($0)" }.joined(separator: "\t")
        linea = linea + "]"
        print(linea)
    }
}

func imprimir2(_ matriz: [[Int]]) {
  print("print matrix with sums for rows and columns")
    for fila in matriz {
        // El \t añade un tabulador para que las columnas se alineen
        var linea = "["
        linea = linea + fila.map { "\($0)" }.joined(separator: "\t")
        linea = linea + "]"
        linea = linea + " : " + String(fila.reduce(0, +))
        print(linea)
    }

    let sumaCol=sumarColumnas(de: matriz)
    var linea = " "
    linea = linea + sumaCol.map { _ in "-" }.joined(separator: "\t")
    linea = linea + " "
    // linea = linea + " : " + String(sumaCol.reduce(0, +))
    print(linea)
    
    linea = "["
    linea = linea + sumaCol.map { "\($0)" }.joined(separator: "\t")
    linea = linea + "]"
    linea = linea + " : " + String(sumaCol.reduce(0, +))
    print(linea)
    
}

func calculateComplement(de matrix: [[Int]]) -> [[Int]] {
    return matrix.map { fila in
        fila.map { $0 == 0 ? 1 : 0 } // Si es 0 pon 1, si no pon 0
    }
}


func calculateCoordenates(de matrix: [[Int]]) {
  
  imprimir2(matrix)
  let sumaCol = sumarColumnas(de: matrix)
  let sumaFil = sumarFilas(de: matrix)
  
  let firstIndex = firstNonZero(in: sumaCol, startingAt: 0) 
  let subCol = Array(sumaCol[firstIndex...]) // Convertimos el Slice a Array
  // print("Sub-arreglo desde el primer no cero: \(subCol)")
  let secondIndex = firstZero(in: subCol, startingAt: 0)
  // print(String(firstIndex) + "," + String(secondIndex))
  
  let thirdIndex = firstNonZero(in: sumaFil, startingAt: 0) 
  let subFil = Array(sumaFil[thirdIndex...]) // Convertimos el Slice a Array
  // print("Sub-arreglo desde el primer no cero: \(subFil)")
  let fourthIndex = firstZero(in: subFil, startingAt: 0)
  // print(String(thirdIndex) + "," + String(fourthIndex))
  
  let topLeft = String(thirdIndex) + " " + String(firstIndex)
  let bottomRight = String(thirdIndex + fourthIndex - 1) + " " + String(firstIndex + secondIndex - 1)
  print("Coordinates are: top-left " + topLeft + ", bottom-right " + bottomRight)
}

func getSubmatrix(of matrix: [[Int]], fromRow r: Int, fromCol c: Int) -> [[Int]] {
    // 1. Validamos que la coordenada esté dentro de la matriz
    guard r < matrix.count && c < (matrix.first?.count ?? 0) else { return [] }
    
    // 2. Cortamos las filas desde 'f' hasta el final
    let filasCortadas = matrix[r...]
    
    // 3. De cada fila, cortamos desde 'c' hasta el final
    let submatrix = filasCortadas.map { row in
        Array(row[c...]) // Convertimos el Slice a Array
    }
    
    return submatrix
}

///New aproach

var complement = calculateComplement(de: miMapa)

var coordinates = getStartCoordinates(of: complement)
imprimir(complement)

var i = 1

while(isCoordinateInRange(of: complement, at: coordinates) ){
  print(" ")
  print("step "+String(i))
  let row = coordinates.row
  let col = coordinates.col
  let oneCol = firstOne(in: complement[row], startingAt: col)
  var oneCoordinates = (row, oneCol)
  
  var newCoordinates = getEndRectangleCoodinates(of: complement, from: oneCoordinates)
  
  print(oneCoordinates)
  print(newCoordinates)

  
  deleteRectangle(of: &complement, from: oneCoordinates, to: newCoordinates)

  coordinates = getStartCoordinates(of: complement)
  print("start coordinates",coordinates)
  i+=1
  imprimir(complement)
}




func isCoordinateInRange(of matrix: [[Int]], at coordinates: (row: Int, col: Int)) -> Bool {
    let r = coordinates.row
    let c = coordinates.col
    
    // Validamos que sea mayor o igual a 0 Y menor que el conteo total
    let rowExists = r >= 0 && r < matrix.count
    let colExists = c >= 0 && c < (matrix.first?.count ?? 0)
    
    return rowExists && colExists
}

func getStartCoordinates(of matrix: [[Int]]) -> (row: Int, col: Int) {
    let sumaCol = sumarColumnas(de: matrix)
    let sumaFil = sumarFilas(de: matrix)
    
    let col = firstNonZero(in: sumaCol, startingAt: 0)
    let row = firstNonZero(in: sumaFil, startingAt: 0) 
    if (row > -1){
        return (row, col)
    }
    return (-1, -1)
}

func getEndRectangleCoodinates(of matrix: [[Int]], from coordinates:(row: Int, col: Int)) -> (row: Int, col: Int) {
    
    let row = matrix[coordinates.row]
    let col = getColumn(coordinates.col, of: matrix)
    
    var colIndex = firstZero(in: row, startingAt: coordinates.col) - 1
    var rowIndex = firstZero(in: col, startingAt: coordinates.row) - 1
    
    if (rowIndex == -2){
      rowIndex = lastOne(in: col, startingAt: coordinates.row)
    }
    if (colIndex == -2){
      colIndex = lastOne(in: row, startingAt: coordinates.col)
    }
    
    return (rowIndex, colIndex)
}

func getColumn(_ n: Int, of matriz: [[Int]]) -> [Int] {
    // Entramos en cada fila y sacamos el elemento en el índice n
    return matriz.map { fila in fila[n] }
}

func deleteRectangle(of matrix: inout [[Int]], from initCoordinates: (row: Int, col: Int), to endCoordinates: (row: Int, col: Int)) {
    let row = initCoordinates.row
    let col = initCoordinates.col
    let hight = endCoordinates.row - row + 1
    let width = endCoordinates.col - col + 1
  
    dibujarRectangulo(en: &matrix, f: row, c: col, alto: hight, ancho: width)
}

//Optimal solution, given not adjacent rectangles

func findRectanglesEfficiently(in matrix: [[Int]]) -> [CGRect] {
    var rects: [CGRect] = []
    let rows = matrix.count
    let cols = matrix.first?.count ?? 0
    
    for r in 0..<rows {
        for c in 0..<cols {
            // Solo procesamos si es un 1 Y NO tiene un 1 arriba ni a la izquierda
            // (Esto significa que es una esquina superior izquierda nueva)
            if matrix[r][c] == 1 {
                let hasOneAbove = r > 0 && matrix[r-1][c] == 1
                let hasOneLeft = c > 0 && matrix[r][c-1] == 1
                
                if !hasOneAbove && !hasOneLeft {
                    // Encontrar ancho y alto desde aquí
                    var width = 0
                    while c + width < cols && matrix[r][c + width] == 1 { width += 1 }
                    
                    var height = 0
                    while r + height < rows && matrix[r + height][c] == 1 { height += 1 }
                    
                    rects.append(CGRect(x: c, y: r, width: width, height: height))
                }
            }
        }
    }
    return rects
}
