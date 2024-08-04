const mongoose = require('mongoose');

// Define the schema for the timetable
const timetableSchema = new mongoose.Schema({
  subject: {
    type: String,
    required: true, // Ensure the subject field is required
  },
  description: {
    type: String,
    required: true, // Ensure the description field is required
  },
  image: {
    type: String, // Store image as a Base64 encoded string
    default: '',  // Default to an empty string if no image is provided
  },
}, {
  timestamps: true, // Add createdAt and updatedAt timestamps
});

// Create the model using the schema
const Timetable = mongoose.model('Timetable', timetableSchema);

module.exports = Timetable;
