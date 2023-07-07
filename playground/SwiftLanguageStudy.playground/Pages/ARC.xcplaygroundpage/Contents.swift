
import Foundation

class Person {
    var name: String
    var apartment: Apartment?
    init(name: String) { self.name = name }
}

class Apartment {
    var address: String
    var tenant: Person?
    init(addr: String) { address = addr }
}

var john: Person? = Person(name: "John")
var addr1: Apartment? = Apartment(addr: "Melbourne")

// Create strong ref cycle!
john!.apartment = addr1
addr1!.tenant = john


