const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  lastName: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
  },
  password: {
    required: true,
    type: String,
  },
  userType: {
    type: String,
  },
  age: {
    type: Number,
  },
  bloodType: {
    type: String,
  },
  class: {
    type: String,
  },
  department: {
    type: String,
  },
  sex: {
    type: String,
    enum: ["male", "female", "other"],
  },
});

const User = mongoose.model("User", userSchema);
module.exports = User;
