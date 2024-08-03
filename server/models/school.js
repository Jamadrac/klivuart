// server/models/school.js
const mongoose = require ("mongoose");

const schoolSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  timetable: {
    type: String, // timetable is a URL or base64 string of the image
  },
  attendance: [
    {
      studentId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
      },
      status: {
        type: String,
        enum: ["present", "absent"],
        required: true,
      },
      teacherId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
      },
      date: {
        type: Date,
        default: Date.now,
      },
    },
  ],
  classAssignment: {
    type: String,
  },
  examResult: {
    type: String,
  },
});

const School = mongoose.model("School", schoolSchema);
module.exports = School;
