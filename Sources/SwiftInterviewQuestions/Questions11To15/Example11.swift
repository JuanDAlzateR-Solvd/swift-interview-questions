enum Question11 {
    static func run() {
  
        let map = ["a": 1, "b": 2, "c": 1, "d": 3, "e": 2, "f": 2]
        let result = revertMap(from: map)
        print("Reversed map: \(result)")
    }

    static func revertMap<K, V>(from dictionary: [K: V]) -> [V: [K ]] {
        var reversed: [V: [K ]] = [:]
        for (key, value) in dictionary {
            reversed[value, default: []].append(key)
        }
        return reversed
    }
    
}

