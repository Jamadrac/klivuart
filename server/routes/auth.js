const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");

authRouter.post("/api/bulkRegister", async (req, res) => {
  const users = req.body; // Array of user objects
  try {
    // Hash passwords and prepare user objects for insertion
    const hashedUsers = await Promise.all(
      users.map(async (user) => {
        const hashedPassword = await bcryptjs.hash(user.password, 8);
        return {
          ...user,
          password: hashedPassword, // Hash the password
        };
      })
    );

    // Insert all users into the database
    const result = await User.insertMany(hashedUsers);

    res.status(201).json({ message: "Users registered successfully!", result });
  } catch (error) {
    res.status(400).json({ message: "Failed to register users", error });
  }
});

authRouter.post("/register/admin", async (req, res) => {
  const { name, mobile, email, department, username, password } = req.body;
  try {
    const newUser = new User({
      name,
      mobile,
      email,
      department,
      username,
      password,
      userType: "admin",
    });
    await newUser.save();
    res.status(200).json({ message: "User registered successfully!" });
  } catch (error) {
    res.status(400).json({ message: "Failed to register user", error });
  }
});
// Get all users
authRouter.get("/api/users", async (req, res) => {
  try {
    const users = await User.find(); // Fetch all users from the database
    res.json(users); // Return users as a JSON response
  } catch (error) {
    res
      .status(500)
      .json({ message: "Failed to fetch users", error: error.message });
  }
});

// Get a user by ID
authRouter.get("/api/users/:id", async (req, res) => {
  const { id } = req.params; // Extract ID from the URL parameter
  try {
    const user = await User.findById(id); // Find user by ID
    if (!user) {
      return res.status(404).json({ message: "User not found" }); // Handle case where user does not exist
    }
    res.json(user); // Return the user data
  } catch (error) {
    res
      .status(500)
      .json({ message: "Failed to fetch user", error: error.message });
  }
});

authRouter.get("/api/admins", async (req, res) => {
  try {
    const admins = await User.find({ userType: "admin" });

    // Respond with the list of admin users
    res.json(admins);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Sign Up
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Sign In
authRouter.post("/api/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get user data
authRouter.get("/", async (req, res) => {
  try {
    // Fetch user from database based on some user identifier, if available
    const user = await User.findById(req.userId); // Assuming req.userId is set somewhere
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    // Respond with user data
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update User Details
authRouter.put("/api/updateUser/:id", async (req, res) => {
  const {
    name,
    email,
    userType,
    age,
    bloodType,
    class: userClass,
    department,
    sex,
  } = req.body;
  try {
    // Ensure that the email is not already used by another user
    const existingUser = await User.findOne({
      email,
      _id: { $ne: req.params.id },
    });
    if (existingUser) {
      return res.status(400).json({
        success: false,
        msg: "Another user with the same email already exists!",
      });
    }

    // Find user by id and update their details
    const user = await User.findByIdAndUpdate(
      req.params.id,
      {
        name,
        email,
        userType,
        age,
        bloodType,
        class: userClass,
        department,
        sex,
      },
      { new: true, runValidators: true }
    );

    if (!user) {
      return res.status(404).json({ success: false, msg: "User not found" });
    }

    res.json({ success: true, msg: "User updated successfully!", user });
  } catch (e) {
    res.status(500).json({ success: false, error: e.message });
  }
});

module.exports = authRouter;
