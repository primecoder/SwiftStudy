import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    
    @State private var scale = CGFloat(1)
    @State private var opacity = 1.0
    
    var body: some View {
        ZStack {
            
            VStack {
                makeRoundButton()
                Spacer()
            }
            
            FullScreenBackgroundView(isPresented: $isPresented)
            BottomSheetView(isShowing: $isPresented, maxHeight: 500) {
                ZStack {
                    Color(UIColor(red: 0.862, green: 0.862, blue: 0.862, alpha: 1.00))
                    
                    Circle()
                        .fill(Color.green)
                        .opacity(opacity)
                        .frame(width: 200)
                        .scaleEffect(scale)
                    
                    Text("SwiftUI rocks!").bold()
                }
                .onChange(of: isPresented) { (_) in
                    if !isPresented {
                        scale = 1
                        opacity = 1
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.easeInOut(duration: 0.8)) {
                                scale = 6
                                opacity = 0.0
                            }
                        }
                    }
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    @ViewBuilder
    func makeRoundButton() -> some View {
        Text("Present!")
            .padding(.vertical, 30)
            .padding(.horizontal, 100)
            .background(Color.gray)
            .cornerRadius(12)
            .shadow(color: Color.gray, radius: 5, x: 5, y: 5)
            .onTapGesture { isPresented = true }
            .padding(.top, 200)
            .padding(.horizontal, 50)
    }
}

/// Full screen view with opaque background color.
/// When presented, it blocks iteraction to UI elements under it.
struct FullScreenBackgroundView: View {
    var bgColor: Color = Color.black
    var opacity: Double = 0.6
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack { Text("") }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background((isPresented) ? bgColor.opacity(opacity) : bgColor.opacity(0.0))
            .edgesIgnoringSafeArea(.all)
            .onTapGesture { isPresented.toggle() }
    }
}

