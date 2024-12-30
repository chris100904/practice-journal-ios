struct PracticeSession: Codable {
    let id: UUID
    let userId: String
    let duration: TimeInterval
    let notes: String
    let metronomeBPM: Int?
    let date: Date
    let recordingPath: String?
    
    init(userId: String, 
         duration: TimeInterval, 
         notes: String, 
         metronomeBPM: Int? = nil,
         recordingPath: String? = nil) {
        self.id = UUID()
        self.userId = userId
        self.duration = duration
        self.notes = notes
        self.metronomeBPM = metronomeBPM
        self.date = Date()
        self.recordingPath = recordingPath
    }
}
