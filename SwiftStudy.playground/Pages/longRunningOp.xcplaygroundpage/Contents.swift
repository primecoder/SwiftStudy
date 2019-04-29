/*:
 Study asynchronous functions

 - Author: Ace Authors

 */
import Foundation

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
 */
