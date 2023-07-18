
import Foundation
import Combine

enum Mood: String {
    case happy = "Happy"
    case sad = "Sad"
}

// This demonstrates the use of the 2nd publisher/subject.
// CurrentValueSubject published a new element whenever it's value is changed.
let moodSwingSubj = CurrentValueSubject<Mood, Never>(.sad)
print("Current mood: \(moodSwingSubj.value)")

// Change value of the subject by calling 'send()'.
// This time it has no subscriber.
moodSwingSubj.send(.happy)
print("Current mood: \(moodSwingSubj.value)")

// Register the first subscriber.
var changeCount = 0
moodSwingSubj.sink { (mood) in
    changeCount += 1
    print("\(changeCount): Ahh. Mood is changed again to: \(mood)")
}

moodSwingSubj.send(.sad)

// Register 2nd subscriber.
moodSwingSubj.sink { (mood) in
    print("Audience #2: Me too interested in your mood: \(mood)")
}

moodSwingSubj.send(.happy)
