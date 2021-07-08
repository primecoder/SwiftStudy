//
//  ContentView.swift
//  ShapeManiac
//
//  Created by random on 29/4/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            
            OffCenteredTriangleView(topLeftColor: .yellow,
                                    bottomRightColor: .gray,
                                    lineColor: .white)
                .frame(width: 350, height: 250)
                .clipped()
        }
    }
}

struct OffCenteredTriangleView: View {
    var topLeftColor: Color
    var bottomRightColor: Color
    var lineColor: Color
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RectangleView(bgColor: topLeftColor)
            OffCenteredTriangle()
                .fill(bottomRightColor)
            DashedLine()
                .stroke(lineColor, style: StrokeStyle(lineWidth: 5, dash: [6, 3]))
        }
    }
    
    internal struct DashedLine: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + (rect.maxY / 5.0)))
            
            return path
        }
    }
    
    internal struct OffCenteredTriangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + (rect.maxY / 5.0)))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            return path
        }
    }
    
    internal struct RectangleView: View {
        var bgColor: Color = .gray
        var body: some View {
            Rectangle()
                .fill(bgColor)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
