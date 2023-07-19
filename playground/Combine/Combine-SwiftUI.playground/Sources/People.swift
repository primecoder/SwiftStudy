import Foundation

/*
 NOTE on reusing struct in Playground (only applicable for when using Playground)
 The below struts when including directly onto a playground page, can be as
 simple as shown here.
 
     struct People: Codable {
        var persons: [Person]
     }
     
     struct Person: Codable {
         var id: Int
         var birthdate: String
         var name: String
         var surname: String
     }
 
 However, when they are made reusable (by putting in top-level 'Sources' folder)
 They need to be defined as shown below.
 
 [aa-20230719]
 */

public struct People: Codable {
    public var persons: [Person]
    
    public init(persons: [Person] = []) {
        self.persons = persons
    }
    
    public static let mockedPeople = People(
        persons: [
            Person(id: 1, name: "Ace", surname: "Awesome"),
            Person(id: 2, name: "Indiana", surname: "Jones"),
            Person(id: 3, name: "Emmett", surname: "Brown"),
            Person(id: 4, name: "Tony", surname: "Stark"),
            Person(id: 5, name: "Sherlock", surname: "Holmes"),
        ]
    )
}

public struct Person: Codable, Identifiable {
    public var id: Int
    public var birthdate: String
    public var name: String
    public var surname: String
    
    public init(
        id: Int = 0,
        birthdate: String = "",
        name: String = "",
        surname: String = ""
    ) {
        self.id = id
        self.birthdate = birthdate
        self.name = name
        self.surname = surname
    }
}
