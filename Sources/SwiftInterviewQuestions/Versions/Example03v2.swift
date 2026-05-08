enum Question03v2: InterviewQuestion {
    static func run() {
        let input = "start2[b3[cd]middle5[f]]end"
        print("EncodedString: \(input)")
        let result = decode(input) 
        print("DecodedString: \(result)")

    }

    static func countBrackets(str: String) -> [Int]{
      var n = 0
      var array: [Int] = []
      for char in str {
        if (char == "["){
          n += 1
        }else if (char == "]"){
          n -= 1
        }
        array.append(n)
      }
      return array
    }

    static func extractContentInBrackets(_ str: String) -> (String.Index,String.Index){
      var n = 0
      var j = 0
      var index = str.startIndex
      
      while(str[index] != "["){
        // print(j)
        // j += 1 
        
        index = str.index(after: index)
        
        if (index == str.endIndex){
          return (str.endIndex,str.endIndex)
        }
      }
  
      n += 1
      let start = index
      
      while (n>0){
        if (index == str.endIndex){
          return (str.endIndex,str.endIndex)
        }
        
        index = str.index(after: index)
        if (str[index] == "["){
          n += 1
        } else if (str[index] == "]"){
          n -= 1
        }
        
      }
      
      let end = index
      return (start,end)
  }

    static func splitWordAndNumber(_ str: String) -> (word:String, number: Int){
      let start = str.startIndex
      var index = start
      let end = str.endIndex
      let digits = "0123456789"
      while(!digits.contains(str[index])){
        index = str.index(after: index)
        if (index == end){
          return (str, 1)
        }
      }
      
      let word = String(str[start..<index])
      let number = Int(String(str[index..<end])) ?? 1
      return (word, number)
      
    }

    static func decode(_ str: String) -> String{
      guard str != "" else {
        return str
      }
      
      let (start, end) = extractContentInBrackets(str)
      let prefix = String(str[str.startIndex..<start])
      
      guard start != str.endIndex else {
        return str
      }

      let start2 = str.index(after: start)
      let content = String(str[start2..<end])
      
      var sufix = ""
      if (end != str.endIndex){
          let end2 = str.index(after: end)
          sufix = String(str[end2..<str.endIndex])
      }
      
      let (word, number) = splitWordAndNumber(prefix)
      
      print("word: \(word), number: \(number), content \(content), sufix: \(sufix) ")
      
      return word + String(repeating: decode(content), count: number) + decode(sufix)
    }
    

}