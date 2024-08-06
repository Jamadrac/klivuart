const mongoose = require("mongoose");

const timetableSchema = mongoose.Schema({
  subject: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  image: {
    type: String, // Base64 encoded image or URL
  },
});

const Timetable = mongoose.model("Timetable", timetableSchema);
module.exports = Timetable;
