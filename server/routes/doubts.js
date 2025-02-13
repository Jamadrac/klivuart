const express = require("express");
const Doubt = require("../models/doubt");

const router = express.Router();

// Route to submit a doubt
router.post("/api/doubts", async (req, res) => {
  try {
    const { email, subject, statement } = req.body;

    const doubt = new Doubt({
      email, // Changed from studentName to email
      subject,
      statement,
    });

    await doubt.save();
    res.status(201).json({ message: "Doubt submitted successfully", doubt });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Route to get all doubts
router.get("/api/doubts", async (req, res) => {
  try {
    const doubts = await Doubt.find();
    res.status(200).json(doubts);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Add a new route to get doubts by email
router.get("/api/doubts/:email", async (req, res) => {
  try {
    const email = req.params.email;
    const doubts = await Doubt.find({ email });

    if (doubts.length === 0) {
      return res
        .status(404)
        .json({ message: "No doubts found for this email" });
    }

    res.status(200).json(doubts);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
