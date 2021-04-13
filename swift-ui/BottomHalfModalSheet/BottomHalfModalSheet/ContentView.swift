import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach((1...100), id: \.self) { _ in
                        Button("Present!") {
                            isPresented.toggle()
                        }
                    }
                }
            }
            
            VStack {
                Text("")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background((isPresented) ? Color.yellow.opacity(0.3) : Color.yellow.opacity(0.0))
            .edgesIgnoringSafeArea(.all)
            
            BottomSheetView(isShowing: $isPresented, maxHeight: 500) {
                ZStack {
                    Color.green
                    Button("Toggle Present!") {
                        isPresented.toggle()
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}


