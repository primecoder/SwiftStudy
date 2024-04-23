/*:
 
 # Custom Publisher

 Creating my own publisher, subscriber, and etc.

 - SeeAlso:
    - [Building custom Combine publishers in Swift](https://www.swiftbysundell.com/articles/building-custom-combine-publishers-in-swift/)

 - Author: Ace Authors
 - Since: 2024-04-23
 */


import Cocoa
import Combine

class MyPublisher: Publisher {
    typealias Output = Date
    typealias Failure = Never

    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Date == S.Input {
        <#code#>
    }
}
