enum Question12 {
    static func run() {
  
        let array = ["a", "b", "c", "d", "e", "f"]
        let result = pairs(from: array)   
        print("Pairs: \(result)")
    }

    static func pairs<K>(from array: [K]) -> [[K]] {
        var pairs: [[K]] = []
        let n = array.count
        for i in 0..<n-1 {
            for j in i+1..<n {
                pairs.append([array[i], array[j]])
            }
        }
        return pairs
    }
    
}

