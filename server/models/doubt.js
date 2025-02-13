const mongoose = require("mongoose");

const doubtSchema = new mongoose.Schema({
  email: {
    type: String,
    required: true,
    trim: true,
    lowercase: true,
    validate: {
      validator: function (v) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v);
      },
      message: (props) => `${props.value} is not a valid email address!`,
    },
  },
  subject: {
    type: String,
    required: true,
    trim: true,
  },
  statement: {
    type: String,
    required: true,
    trim: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
  status: {
    type: String,
    enum: ["pending", "answered", "closed"],
    default: "pending",
  },
});

const Doubt = mongoose.model("Doubt", doubtSchema);

module.exports = Doubt;
