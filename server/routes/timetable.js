const express = require('express');
const router = express.Router();
const Timetable = require('../models/school');

// Add timetable
router.post('/addTimetable', async (req, res) => {
  try {
    const { subject, description, image } = req.body;
    const newTimetable = new Timetable({ subject, description, image });
    await newTimetable.save();
    res.status(200).json({ message: 'Timetable added successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Failed to add timetable', error: err.message });
  }
});

// Delete timetable
router.delete('/deleteTimetable/:id', async (req, res) => {
  try {
    const { id } = req.params;
    await Timetable.findByIdAndDelete(id);
    res.status(200).json({ message: 'Timetable deleted successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Failed to delete timetable', error: err.message });
  }
});

module.exports = router;
