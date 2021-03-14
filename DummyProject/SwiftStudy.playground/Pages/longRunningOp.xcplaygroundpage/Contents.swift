/*:

 ## Study asynchronous functions
 - longRunningOp
 - [Escape Closure - Scenario 1](escapeClosure)
 - [Escape Closure - Scenario 2](escapeClosure2)

 ## Integrating with Package Management System

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

 This Playground was created outside the project and then moved into this project.
 This method does *not* work with Cocoapods - Playground doesn't recognise any external framework!

 - see [NOT WORKING scenario](UseWithCocoapods)

 ---
 Author: Ace Authors

 */
import Foundation

// External framework does not work with this playground.
// import SwiftyJSON

/**
 This is a traditional function that simulates a long running operation.
 */
func longRunningOp(_ opName: String, delaySecond: Int) {
    print("\(opName): enter")
    let dispatchQueue = DispatchQueue(label: opName)
    dispatchQueue.async {
        print("\(dispatchQueue.label): start long running process...")
        usleep(1000000 * UInt32(delaySecond))
        print("\(dispatchQueue.label): completed long running process")
    }
    print("\(opName): exit")
}

longRunningOp("a", delaySecond: 10)
longRunningOp("b", delaySecond: 3)


/*:
 History
 - 2019.04.29 Created by Ace
 - 2019.05.05 Modified to use with Cocoapods
 */
