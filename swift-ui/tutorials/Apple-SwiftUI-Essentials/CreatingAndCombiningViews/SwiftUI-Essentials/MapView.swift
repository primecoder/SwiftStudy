//
//  MapView.swift
//  SwiftUI-Essentials
//
//  Created by random on 26/9/20.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    // required by UIViewRepresentable
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    // required by UIViewRepresentable
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: -37.9697, longitude: 145.0430)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .previewDevice("iPhone 11")
    }
}
