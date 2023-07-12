/// This is my first test using SwiftUI + Playground.
/// [aa-20200911]

//: What is prose?

import SwiftUI
import PlaygroundSupport

/// Demonstrate the simplest SwiftUI view.
struct ContentView: View {
    var tStark = Person(firstName: "Tony", lastName: "Stark")

    var body: some View {
        Text("👉\(String(describing: tStark)) was here")
            .font(.system(.largeTitle, design: .monospaced))
            .bold()
            .foregroundColor(.orange)
            .background(Color.blue)
    }
}

var someView = ContentView()
someView.tStark.firstName = "T"

PlaygroundPage.current.setLiveView(someView)
