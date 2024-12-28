import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                headerSection
                VStack(alignment: .leading, spacing: 24) {
                    weeklyDigestSection
                    
                    VStack(spacing: 16) {
                        referenceRecordingsSection
                        todoSection
                    }

                }
                .padding() // Apply padding to the inner VStack
            }
            .background(Color.white)
        }
        .ignoresSafeArea(edges: .top)
    }
}

private var headerSection: some View {
    VStack(alignment: .leading, spacing: 4.0) {
        Spacer()
            .frame(height: 40) // Adjust this value based on testing
        
        VStack(alignment: .leading, spacing: 4.0) {
            Text("Hi, ______")
                .font(.largeTitle)
                .bold()
            Text("Welcome Back!")
                .font(.title3)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
    .frame(maxWidth: .infinity)
    .frame(height: 140) // Make header taller
    .background(Color("HomeViewHeaderColor"))
}


private var weeklyDigestSection: some View {
    VStack(alignment: .leading, spacing: 16) {
        Text("Weekly Digest").font(.title2).fontWeight(.semibold)
        
        TabView {
            WeeklyDigestCard(practiceCount: 5, mood: "sad", recordingCount: 2)

            // insert more cards for carousel
        }.frame(height: 150).tabViewStyle(PageTabViewStyle()) 
    }
//    .background(Color("AccentColor").opacity(0.1)).cornerRadius(16)
}


struct WeeklyDigestCard: View {
    let practiceCount: Int
    let mood: String
    let recordingCount: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "chart.bar.fill")
                Text("You've practiced for \(practiceCount) times this week!")
            }
            
            HStack {
                Image(systemName: "face.smiling")
                Text("Your average mood is \(mood).")
            }
            
            HStack {
                Image(systemName: "mic.fill")
                Text("You've recorded \(recordingCount) times this week. Brave!")
            }
        }
        .padding()
        .background(Color("NavbarColor"))
        .cornerRadius(30)
    }
}

private var referenceRecordingsSection: some View {
    VStack(alignment: .leading, spacing: 8) {
        Text("Reference Recordings")
            .font(.headline)
        
        RoundedRectangle(cornerRadius: 30)
            .fill(Color("NavbarColor").opacity(0.8))
            .frame(height: 150)
    }
}

private var todoSection: some View {
    VStack(alignment: .leading, spacing: 8) {
        Text("Practice Suggestions")
            .font(.headline)
        
        RoundedRectangle(cornerRadius: 30)
            .fill(Color("NavbarColor").opacity(0.8))
            .frame(height: 150)
    }
}
