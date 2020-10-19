//
//  ContentView.swift
//  SwiftUI-Essentials
//
//  Created by random on 25/9/20.
//

// [aa-20200925] UI elements can be updated using element Inspector! Pretty cool!

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300)

            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                Text("Authors Headquarter")
                    .font(.title)
                    .multilineTextAlignment(.leading)

                HStack {
                    Text("Pyingerra Crescent")
                        .font(.subheadline)

                    Spacer()

                    Text("Cheltenham")
                        .font(.subheadline)
                }
            }
            .padding()

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
