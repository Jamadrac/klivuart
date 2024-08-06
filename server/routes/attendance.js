const express = require('express');
const User = require('../models/user'); // Assuming user model exists
const Attendance = require('../models/attendance');
const authRouter = express.Router();

// Get all students (attendees)
authRouter.get('/api/attendees', async (req, res) => {
  try {
    const attendees = await User.find({ userType: 'student' });
    res.json(attendees);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Post attendance record
authRouter.post('/api/attendance', async (req, res) => {
  const { studentId, status, teacherEmail } = req.body;
  try {
    const attendance = new Attendance({
      studentId,
      status,
      teacherEmail
    });
    await attendance.save();
    res.status(201).json({ message: 'Attendance recorded successfully!' });
  } catch (error) {
    res.status(400).json({ message: 'Failed to record attendance', error });
  }
});

module.exports = authRouter;
