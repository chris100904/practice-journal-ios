import SwiftUI

struct Navbar: View {
    @State private var selectedTab = 0

    var body: some View {
        HStack {
            TabBarButton(imageName: "house.fill", title: "Home", isSelected: selectedTab == 0) {
                selectedTab = 0
            }
            TabBarButton(imageName: "book.fill", title: "Journal", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
            TabBarButton(imageName: "play.fill", title: "Practice", isSelected: selectedTab == 2) {
                selectedTab = 2
            }
            TabBarButton(imageName: "music.note", title: "Spotify", isSelected: selectedTab == 3) {
                selectedTab = 3
            }
            TabBarButton(imageName: "person.fill", title: "Profile", isSelected: selectedTab == 4) {
                selectedTab = 4
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct TabBarButton: View {
    let imageName: String
    let title: String  
    let isSelected: Bool 
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: imageName).foregroundColor(isSelected ? Color.green : Color.gray)
                Text(title).font(.caption).foregroundColor(isSelected ? Color.green : Color.gray)
            }
        }
    }
}