import SwiftUI
import PlaygroundSupport

// Must drag-and-drop images file into the "Resouces" folder.

struct ContentView: View {
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(named: "wowee.jpg")!)
                .resizable()
                .scaledToFill()

            Image(uiImage: UIImage(named: "ace.jpg")!)
                .resizable()
                .scaledToFill()
                .blendMode(.color)

        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
