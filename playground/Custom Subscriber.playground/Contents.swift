import Cocoa
import Combine

let names = [
    "john", "joe", "tim", "tom"
]

let x = names.publisher.sink { name in
    print("Sink: \(name)")
}

class SeqSubscriber<Type>: Subscriber {
    typealias Input = Type
    typealias Failure = Never

    func receive(_ input: Type) -> Subscribers.Demand {
        print("\(Type.self) Recieve: \(input)")
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("\(Type.self) Receive completed")
    }
    
    func receive(subscription: any Subscription) {
//        subscription.request(.max(2))
        subscription.request(.unlimited)
    }
}

names.publisher.subscribe(SeqSubscriber<String>())
names.map { $0.count }.publisher.subscribe(SeqSubscriber<Int>())
[1, 2, 3, 4, 5].publisher.subscribe(SeqSubscriber<Int>())
