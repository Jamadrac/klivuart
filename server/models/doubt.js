// models/doubt.js
const mongoose = require("mongoose");

const doubtSchema = new mongoose.Schema({
  studentName: {
    type: String,
    required: true,
  },
  subject: {
    type: String,
    required: true,
  },
  statement: {
    type: String,
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const Doubt = mongoose.model("Doubt", doubtSchema);

module.exports = Doubt;
