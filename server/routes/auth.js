// server/routes/auth.js
import { Router } from "express";
import { hash, compare } from "bcryptjs";
import User, { findOne, findById, findByIdAndUpdate } from "../models/user";
const authRouter = Router();
import { sign, verify } from "jsonwebtoken";
import auth from "../middleware/auth";

// Sign Up
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await hash(password, 8);

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

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get user data
authRouter.get("/", auth, async (req, res) => {
  const user = await findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

// Update User Details
authRouter.put("/api/updateUser/:id", auth, async (req, res) => {
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
    const existingUser = await findOne({
      email,
      _id: { $ne: req.params.id },
    });
    if (existingUser) {
      return res
        .status(400)
        .json({
          success: false,
          msg: "Another user with the same email already exists!",
        });
    }

    // Find user by id and update their details
    const user = await findByIdAndUpdate(
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
      { new: true, runValidators: true } // Return the updated document and run validators
    );

    if (!user) {
      return res.status(404).json({ success: false, msg: "User not found" });
    }

    res.json({ success: true, msg: "User updated successfully!", user });
  } catch (e) {
    res.status(500).json({ success: false, error: e.message });
  }
});

export default authRouter;
