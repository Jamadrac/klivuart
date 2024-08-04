const express = require('express');
const router = express.Router();
const Timetable = require('../models/Timetable'); // Correct model import

// Add timetable
router.post('/addTimetable', async (req, res) => {
  try {
    const { subject, description, image } = req.body;
    console.log('Request Body:', req.body); // Log the request body

    // Validate required fields
    if (!subject || !description) {
      return res.status(400).json({ message: 'Subject and description are required' });
    }

    const newTimetable = new Timetable({ subject, description, image });
    await newTimetable.save();
    res.status(200).json({ message: 'Timetable added successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Failed to add timetable', error: err.message });
  }
});

// View all timetables
router.get('/Timetables', async (req, res) => {
  try {
    const timetables = await Timetable.find(); // Fetch all timetables
    res.status(200).json(timetables); // Return the timetables
  } catch (err) {
    res.status(500).json({ message: 'Failed to fetch timetables', error: err.message });
  }
});

// View a timetable by ID
router.get('/getTimetable/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const timetable = await Timetable.findById(id); // Fetch timetable by ID

    if (!timetable) {
      return res.status(404).json({ message: 'Timetable not found' });
    }

    res.status(200).json(timetable); // Return the timetable
  } catch (err) {
    res.status(500).json({ message: 'Failed to fetch timetable', error: err.message });
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
