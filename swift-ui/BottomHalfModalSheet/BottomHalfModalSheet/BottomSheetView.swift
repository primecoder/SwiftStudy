//
//  BottomSheetView.swift
//  BottomHalfModalSheet
//
//  Created by random on 13/4/21.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    @Binding var isShowing: Bool
    
    let maxHeight: CGFloat
    let minHeight = 0
    let content: Content
    let snapRatio: CGFloat = 0.25
    let radius = CGFloat(16)
    
    init(isShowing: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        _isShowing = isShowing
        self.maxHeight = maxHeight
        self.content = content()
    }
    
    private var offset: CGFloat {
        isShowing ? 0 : maxHeight
    }
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.yellow)
            .frame(
                width: 48,
                height: 5
            )
    }
    
    func getMaxHeight(screenHeight: CGFloat) -> CGFloat {
        var value: CGFloat
        print("MAX HEIGHT \(screenHeight)")
        if screenHeight < 600 {
            value = screenHeight * 0.75
        } else {
            value = screenHeight * 0.55
        }
        return value
    }
    
    @GestureState private var translation: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding()
                self.content
            }
            .frame(width: geometry.size.width, height: getMaxHeight(screenHeight: self.maxHeight), alignment: .top)
            .background(Color.white)
            .cornerRadius(radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring(), value: isShowing)
            .animation(.interactiveSpring(), value: translation)
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isShowing = value.translation.height < 0
                }
            )
        }
    }
}
