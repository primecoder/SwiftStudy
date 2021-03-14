/*:

 # Integrating with Package Management System

 1. A Playground must be *newly* created inside a project

    *(quirk!)* A playground that created outside a project and added into a project later will not work.

 1. A Podfile should be created as follow:

     ```
     # Podfile

     platform :ios,'12.2'
     use_frameworks!

     workspace 'SwiftStudy'
     project 'DummyProject/DummyProject.xcodeproj'

     target 'DummyProject' do
        pod 'SwiftyJSON'
        pod 'Quick'
        pod 'Nimble'
     end
     ```

 This Playground was created *inside* the project. Playground's pages, created elsewhere, can be copied or
 moved into this Playground.

 ---
 Author: Ace Authors

 */

import Foundation
import SwiftyJSON

var str = "Hello, playground"

print("Hello SwiftyJSON")

let jsonString = """
{
    "name": "ace",
    "surname": "authors"
}
"""

if let data = jsonString.data(using: .ascii) {
    let json = JSON(data: data)
    print(json["name"])
    print(json["surname"])
} else {
    print("No JSON data!")
}



