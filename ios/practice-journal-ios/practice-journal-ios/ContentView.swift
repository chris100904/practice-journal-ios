//
//  ContentView.swift
//  practice-journal-ios
//
//  Created by Christopher Chen on 12/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            JournalView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Journal")
                }
            
            PracticeView()
                .tabItem {
                    Image(systemName: "play.fill")
                    Text("Practice")
                }
            
            SpotifyView()
                .tabItem {
                    Image(systemName: "music.note")
                    Text("Spotify")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        // .background(Color("NavbarColor"))
        .accentColor(Color("NavbarColor"))
    }
}


#Preview {
    ContentView()
}
