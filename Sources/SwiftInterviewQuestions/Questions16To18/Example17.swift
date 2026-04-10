enum Question17 {
    static func run() {        
        let familyTree = FamilyTree()
        let input = [
            "Alice,Garry,Dan,Agnes", 
            "John,Alice,Rufus,Beatrice,Hank", 
            "Beatrice,Clementine,Adam,Frank", 
            "Hank,Gabriel,Gertrude,Rufus"
        ]   

        for family in input {
            familyTree.addToFamilyTree(family: family)
            // print("Added family: \(family)")
        }

        familyTree.calculateLevels()
        familyTree.printFamilyTree()
    }
}

class Person {
    var parent: Person?
    var children: [Person] = []
    var name: String
    var level: Int = 0

    init(name: String) {
        self.name = name
    }

    func setParent(_ parent: Person) {
        self.parent = parent        
    }

    func addChild(_ child: Person) {
        children.append(child)
    }
}

class FamilyTree {
    var people: [String: Person] = [:]
    var root: Person?

    init() {
    }

    func addToFamilyTree(family: String) {
        let familyMembers = family.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }

        let parent = people[familyMembers[0]] ?? Person(name: familyMembers[0])
        people[parent.name] = parent

        for i in 1..<familyMembers.count {
            let child = people[familyMembers[i]] ?? Person(name: familyMembers[i])
            child.setParent(parent)
            parent.addChild(child)
            people[child.name] = child
        }
     
    }
    
    func calculateLevels() {
        guard !people.isEmpty else {
            return
        }
        var person = people.values.first!
        var newParent = person.parent

        while newParent != nil {           
            person = newParent!
            newParent = newParent?.parent
           
        }
        person.level = 0
        root = person
        updateChildrenLevels(for: person)
    }
   
    private func updateChildrenLevels(for person: Person) {        
        for child in person.children {
            child.level = person.level + 1
            updateChildrenLevels(for: child)
        }
    }

    func printFamilyTree() {
        print("family has \(people.count) people")
        guard let root = root else {
            print("Family tree is empty.")
            return
        }
        printChildren(of: root)
    }

    private func printChildren(of person: Person) {
        printPerson(person)        
        for child in person.children {
           printChildren(of: child)
        }
    }

    private func printPerson(_ person: Person) {
        let indent = String(repeating: "....", count: person.level)
        print("\(indent)\(person.name)")        
    }

}

