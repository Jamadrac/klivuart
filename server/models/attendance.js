// models/attendance.js
const mongoose = require('mongoose');

const attendanceSchema = new mongoose.Schema({
  studentId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User', // Assuming User model is used for students
    required: true
  },
  status: {
    type: String,
    enum: ['present', 'absent'],
    required: true
  },
  teacherEmail: {
    type: String,
    required: true
  },
  date: {
    type: Date,
    default: Date.now
  }
});

const Attendance = mongoose.model('Attendance', attendanceSchema);
module.exports = Attendance;
