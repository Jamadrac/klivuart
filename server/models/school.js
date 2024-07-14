// server/models/school.js
import mongoose from "mongoose";

const schoolSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  timetable: {
    type: String, // Assuming timetable is a URL or base64 string of the image
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
    type: String, // URL or base64 string of the photo
  },
  examResult: {
    type: String, // URL or base64 string of the photo
  },
});

const School = mongoose.model("School", schoolSchema);
export default School;
