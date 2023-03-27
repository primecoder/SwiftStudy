print("Hello Closure")

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

let sortedNames = names.sorted { s1, s2 in return s1 > s2 }
print(sortedNames)

// A function which returns a closure (a function which accepts a string as param and returns
// a list of string)
func registration() -> (String) -> [String] {
    var members = [String]()
    func addMember(name: String) -> [String] {
        members.append(name)
        return members.sorted {$0 < $1} // A closure is passed into sorted()
    }
    
    return addMember(name:) // Returns a function with signature matches what is required.
}

let friendRegistry = registration()
print(friendRegistry("joe"))
print(friendRegistry("tom"))
print(friendRegistry("sue"))
print(friendRegistry("c"))
print(friendRegistry("b"))
print(friendRegistry("a"))

