import SwiftUI

struct PracticeView: View {
    @StateObject private var timerManager = TimerManager()
    @StateObject private var practiceSessionManager = PracticeSessionManager.shared
    @State private var isRecording = false
    @State private var showNotes = false
    @State private var isMetronomeOn = false
    @State private var metronomeValue: Double = 60
    @State private var notes: String = ""
    
    var body: some View {
        ZStack {
            Color("PracticeViewColor")

            VStack(spacing: 20) {
                // Back button and top bar
                HStack {
                    Button(action: { /* Handle back action */ }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    }
                    Spacer()
                    
                    if timerManager.elapsedTime > 0 {
                        Button(action: {
                            if !timerManager.isPaused {
                                timerManager.toggleTimer()
                            }
                            
                            let alert = UIAlertController(title: "Are you sure you're done practicing?", 
                                                        message: nil, 
                                                        preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in 
                                // Save practice session
                                let saved = PracticeSessionManager.shared.savePracticeSession(
                                    duration: self.timerManager.elapsedTime,
                                    notes: self.notes,
                                    metronomeBPM: self.isMetronomeOn ? Int(self.metronomeValue) : nil,
                                    recordingPath: self.isRecording ? "path_to_recording" : nil
                                )
                                
                                if saved {
                                    self.timerManager.resetTimer()
                                    self.notes = ""
                                    self.isRecording = false
                                    self.isMetronomeOn = false
                                }
                            }))
                            
                            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in 
                                if !timerManager.isPaused {
                                    timerManager.toggleTimer()
                                }
                            }))
                            
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                            let rootViewController = windowScene.windows.first?.rootViewController {
                                rootViewController.present(alert, animated: true, completion: nil)
                            }
                        }) {
                            Image(systemName: "stop.fill")
                                .foregroundColor(.white)
                                .imageScale(.large)
                        }
                    }
                }
                .padding()
                .background(Color("PracticeViewHeaderColor"))
                
                // Timer display
                Text(timeString(from: timerManager.elapsedTime))
                    .font(.custom("Roboto-Bold", size: 80))
                    .foregroundColor(.white)
                    .monospacedDigit()
                    .tracking(10)
                
                // Control buttons
                HStack(spacing: 40) {
                    // Recording button
                    Button(action: { toggleRecording() }) {
                        Image(systemName: "mic.fill")
                            .foregroundColor(isRecording ? .red : .white)
                            .font(.system(size: 30))
                    }
                    
                    Button(action: { toggleTimer() }) {
                        Image(systemName: timerManager.isPaused ? "play.fill" : "pause.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                    }
                    
                    Button(action: { toggleMetronome() }) {
                        Image("metronome-icon")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                    }
                }
                .padding(.vertical)
                
                // Metronome slider (conditionally shown)
                if isMetronomeOn {
                    VStack {
                        Text("\(Int(metronomeValue))")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(Circle())
                        
                        Slider(value: $metronomeValue, in: 0...120)
                            .tint(.white)
                            .padding(.horizontal)
                    }
                }
                
                Spacer()
                
                // Notes section
                VStack {
                    Button(action: { toggleNotes() }) {
                        HStack {
                            Text("notes ~")
                                .foregroundColor(.white)
                                .font(.custom("Roboto-Bold", size: 32))
                            Image(systemName: showNotes ? "chevron.up" : "chevron.down")
                                .foregroundColor(.white)
                        }
                    }
                    
                    if showNotes {
                        TextEditor(text: $notes)
                            .frame(height: 150)
                            .padding()
                            .background(Color("PracticeViewNotesColor"))
                            .cornerRadius(20)
                            .foregroundColor(Color.black)
                            .scrollContentBackground(.hidden)
                            .font(.custom("Roboto-Regular", size: 12))
                    }
                }
                .padding()
                .padding(.bottom) // add padding at the bottom
            }
        }
    }
    
    // Helper functions
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func toggleRecording() {
        isRecording.toggle()
        // Implement recording logic
    }
    
    private func toggleTimer() {
        timerManager.toggleTimer()
    }
    
    private func toggleMetronome() {
        withAnimation {
            isMetronomeOn.toggle()
        }
    }
    
    private func toggleNotes() {
        withAnimation {
            showNotes.toggle()
        }
    }
}


class TimerManager: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    private var timer: Timer?
    @Published var isPaused: Bool = true
    
    func toggleTimer() {
        if isPaused {
            // Start or resume the timer
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                self?.elapsedTime += 1
            }
        } else {
            // Pause the timer
            timer?.invalidate()
            timer = nil
        }
        isPaused.toggle()
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        elapsedTime = 0
        isPaused = true
    }
    
    deinit {
        timer?.invalidate()
    }
}

