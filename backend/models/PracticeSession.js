const mongoose = require("mongoose");

const practiceSessionSchema = new mongoose.Schema({
  userId: {
    type: String,
    required: true,
  },
  duration: {
    type: Number, // TimeInterval will be stored as Number
    required: true,
  },
  notes: {
    type: String,
    default: "",
  },
  date: {
    type: Date,
    default: Date.now,
  },
  recordingPath: {
    type: String,
    default: null,
  },
});

module.exports = mongoose.model("PracticeSession", practiceSessionSchema);
