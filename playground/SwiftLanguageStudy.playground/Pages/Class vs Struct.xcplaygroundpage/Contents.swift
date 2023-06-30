/*:

 # Struct Vs Class

 The study that shows the differences between Structs and Classes

 OK, what is the fuss about Class vs Struct

 ```

 |  Struct                       | Class                         |
 | ----------------------------- | ----------------------------- |
 | - No inheritant               | - Yes inheritant              |
 | - Value Type                  | - Reference Type              |
 | - use by default              | - When mixed with Objective-C |
 | - faster mem allocation       | - When need control identity  |
 | - auto memberwise initialiser | - faster passing around func  |
 | - No === operator             | - Can use === operator        |   # Identity operator, i.e. point to the same memory

 ```

 ## References

 - [Choosing Between Structs and Classes](https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes)


 - Author: Ace Authors

 - History:
    - 2020.09.24 - Created, Xcode 12, Swift 5.3
    - 2021.03.15 - Revisited

 */

// Do we need Foundation here? Yes, for `@objc` directive.
import Foundation

/// # Support for Inheritance
/// Struct does not support inheritance, while class does.

struct StructA {
    var name: String = "struct A"
}

/// Demonstrates a good practice of extending a protocol in a separate block of code.
/// Extending StructA to conform to CustomStringConvertible protocol, returning
/// a string representation of this object.
extension StructA: CustomStringConvertible {
    var description: String { return "Struct: name=\(name)" }
}

/// This is not OK - compile error.
///
/// struct StructAA: StructA {
/// }

class ClassA {
    var name: String = "class A"
    init(_ name: String = "class A") { self.name = name }
}

extension ClassA: CustomStringConvertible {
    @objc var description: String { return "Class: name=\(name)" }
}

/// This is OK - class can inherite from other class.
class ClassAA: ClassA {
    var anotherName: String = "nickname is class AA"

    // Overriding (extend) parent's implementation. Note the use of '@objc' directive is required.
    @objc override var description: String { return "\(super.description),  anotherName=\(anotherName)" }
}


/// Note: This generates compile error - Nothing can inherite from struct.
///
/// class ClassStructA: StructA {
///
/// }
///

/// # Struct are passed by value. Classes are passed by reference.

/// This function demonstrates the effects of modifying struct object versus
/// class object.
func modifyObj1(structObj: StructA, classObj: ClassA) {
    print("modifyObj1(...)")
    // Not Ok. Compiler warning - Cannot assign to property...
    // structObj.name = "(modified) \(structObj.name)"

    // This is Ok.
    // Notice that, this function can modify class property without using
    // a keyword `inout`.
    classObj.name = "(modifyObj1) \(classObj.name)"
}

func modifyObj2(structObj: inout StructA, classObj: ClassA) {
    print("modifyObj2(..)")
    structObj.name = "(modifyObj2) \(structObj.name)"
    classObj.name = "(modifyObj2) \(classObj.name)"
}

func makeNewObj(structObj: inout StructA, classObj: inout ClassA) {
    print("makeNewObj()")
    structObj = StructA(name: "This is a new Struct A")
    classObj = ClassA("This is a new class A")
}

var structA = StructA()
var classA = ClassA()
var classAA = ClassAA()

print("\(structA)")
print("\(classA)")

// Note: here that ClassAA needs to override `description` implementation
// to display properties from subclass.
print("\(classAA)")


modifyObj1(structObj: structA, classObj: classA)
print("\(structA)")
print("\(classA)")

modifyObj2(structObj: &structA, classObj: classA)
print("\(structA)")
print("\(classA)")

makeNewObj(structObj: &structA, classObj: &classA)
print("\(structA)")
print("\(classA)")


/// Identity Differences

let structA_1 = StructA(name: "A1")
let structA_2 = StructA(name: "A1")
/// Cannot compare identities with struct
/// print("Struct objs identities: \(structA_1 === structA_2)")

let clsA_1 = ClassA("A1")
let clsA_2 = ClassA("A2")
let clsA_1a = clsA_1
print("Class objs identities: \(clsA_1 === clsA_2)")
print("Class objs identities: \(clsA_1 === clsA_1a)")

//: [Next](@next)
