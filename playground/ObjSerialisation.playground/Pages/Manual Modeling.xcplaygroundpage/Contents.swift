//: [Previous](@previous)
/*:
 # Manually Generate Models
 
 In this playground, we will create model of objects manually.
 
 ## History:
 - 2021.04.18, Ace Authors, created.
 
 # Requirement Spec
 
 ## Cars Modeling
 
 - A car has make, i.e. Porsche, Toyota, Jeep, etc
 - body types: coupe, sedan, wagon
 - They have number of cylinder: 4, 6, 8, 10, 11, 12, etc
 - Cylinder layout: Horizontal, V, Rotary
 - Engine types: petrol, deisel, electric, hybrid, etc
 - Transmission layout: front wheel drive, rear wheel drive
 - Engine placements: front, mid, rear
 - Engine sizes (cc): 2000cc, 3400cc, etc
 - Horse power: 330 hp, etc
 */

import Foundation

struct Vehicle: Codable {
    enum BodyType: String, Codable {
        case coupe
        case sedan
        case wagon
    }
    
    enum CylinderLayout: String, Codable {
        case horizontal
        case vertical
        case vshape
        case rotary
    }
    
    enum EngineType: String, Codable {
        case petrol
        case diesel
        case electric
        case hybrid
    }
    
    enum TransmissionLayout: String, Codable {
        case frontWheelDrive
        case rearWheelDrive
        case fulltimeAllWheelDrive
        case allWheelDrive
    }
    
    enum EnginePlacement: String, Codable {
        case front
        case rear
        case mid
    }
    
    var bodyType: BodyType
    var numberOfCylinders: Int
    var cylinderLayout: CylinderLayout
    var engineType: EngineType
    var transmissionLayout: TransmissionLayout
    var enginePlacement: EnginePlacement
    var engineSize: Int
    var horsePower: Int
}

extension Vehicle: CustomStringConvertible {
    var description: String {
        return """
            bodyType: \(bodyType),
            cylinders: \(numberOfCylinders),
            layout: \(cylinderLayout),
            engineType: \(engineType),
            transmission: \(transmissionLayout),
            enginePlacement: \(enginePlacement),
            engineSize: \(engineSize),
            horsePower: \(horsePower)
            """
    }
}

let porscheCaymanR = Vehicle(
    bodyType: .coupe,
    numberOfCylinders: 6,
    cylinderLayout: .horizontal,
    engineType: .petrol,
    transmissionLayout: .rearWheelDrive,
    enginePlacement: .mid,
    engineSize: 3400,
    horsePower: 330
)

// Encoding

if let porscheCaymanRData = try? JSONEncoder().encode(porscheCaymanR) {
    if let dataString = String(data: porscheCaymanRData, encoding: .utf8) {
        print("Car 1: \(dataString)")
    }
}

print("------------------")

// Decode
let porscheCaymanRJsonString = """
    {"bodyType":"coupe","cylinderLayout":"horizontal","enginePlacement":"mid","transmissionLayout":"rearWheelDrive","engineSize":3400,"numberOfCylinders":6,"horsePower":330,"engineType":"petrol"}
"""

if let carFromJson = try? JSONDecoder()
    .decode(
        Vehicle.self,
        from: porscheCaymanRJsonString.data(using: .utf8)!
    ) {
    print("Decode car: \(carFromJson)")
}

//: [Next](@next)
