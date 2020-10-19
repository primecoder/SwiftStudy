/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct LandmarkList: View {

    // SwiftUI managed State - equivalent to React programming.
    // Note: This is replaced by the implementation of ObservableObject via @EnvironmentObject
    // [aa-20200927]
    // @State private var showFavoritesOnly = false

    @EnvironmentObject var userData: UserData

    var body: some View {
        NavigationView {
            List {

                // Passing state 'showFavoritesOnly' to other view (Toggle) using '$' prefix.
                // [aa]
                Toggle(isOn: $userData.showFavoritesOnly) {
                    Text("Favorites Only")
                }

                ForEach(userData.landmarks) { landmark in
                    if !self.userData.showFavoritesOnly || landmark.isFavorite {
                        NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                            LandmarkRow(landmark: landmark)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Landmarks"))
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {

        // My macbook is too underpower to display multiple previews.
        // [aa-20200927]
        let deviceNames = [
            "iPhone SE",
//            "iPhone XS Max"
        ]

        ForEach(deviceNames, id: \.self) { deviceName in
            LandmarkList()
                .environmentObject(UserData())
        }
    }
}
