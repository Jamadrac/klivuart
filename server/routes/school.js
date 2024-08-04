// server/routes/school.js
const express = require("express");
const User = require("../models/user");
const School = require("../models/school");
const { hash } = require("bcryptjs");

const schoolRouter = express.Router();


class Admin {
  // 1. Add Faculty
  static async addFaculty(req, res) {
    try {
      const { name, lastName, email, password } = req.body;

      const existingUser = await User.findOne({ email });
      if (existingUser) {
        return res.status(400).json({ msg: "User with the same email already exists!" });
      }

      const hashedPassword = await hash(password, 8);

      let user = new User({
        email,
        password: hashedPassword,
        name,
        lastName,
        userType: "staff",
      });
      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }

  // 2. Add Student
  static async addStudent(req, res) {
    try {
      const { name, lastName, email, password } = req.body;

      const existingUser = await User.findOne({ email });
      if (existingUser) {
        return res.status(400).json({ msg: "User with the same email already exists!" });
      }

      const hashedPassword = await hash(password, 8);

      let user = new User({
        email,
        lastName,
        password: hashedPassword,
        name,
        userType: "student",
      });
      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }

  // 3. Get All Students
  static async getAllStudents(req, res) {
    try {
      const students = await User.find({ userType: "student" });
      res.json(students);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }

  // 4. View All Timetables
  static async viewAllTimetables(req, res) {
    try {
      const schools = await School.find({}, 'timetable'); // Assuming timetable is a field in the School model

      if (!schools.length) {
        return res.status(404).json({ msg: "No timetables found" });
      }

      // Flatten the timetable data
      const timetables = schools.flatMap(school => school.timetable.map(entry => ({
        id: school._id.toString(), // Ensure the ID is a string
        ...entry // Spread timetable entry fields
      })));

      res.json(timetables);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }

  // 5. Delete Student or Faculty by ID
  static async deleteUserById(req, res) {
    try {
      const { id } = req.params;
      const user = await User.findByIdAndDelete(id);

      if (!user) {
        return res.status(404).json({ msg: "User not found" });
      }

      res.json({ msg: "User deleted successfully" });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
}

class Faculty {
  // 1. Add Timetable
  static async addTimetable(req, res) {
    try {
      const { subject, description, image } = req.body;

      let school = await School.findOne();
      if (!school) {
        school = new School({ name: "Default School", timetable: [] });
      }
      school.timetable.push({ subject, description, image });
      await school.save();

      res.json(school);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }

  // 2. Add Student Results
  static async addStudentResults(req, res) {
    try {
      const { examResult } = req.body;

      let school = await School.findOne();
      if (!school) {
        school = new School({ name: "Default School" });
      }
      school.examResult = examResult;
      await school.save();

      res.json(school);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }

  // 3. Add Attendance
  static async addAttendance(req, res) {
    try {
      const { studentId, status, teacherId } = req.body;

      let school = await School.findOne();
      if (!school) {
        school = new School({ name: "Default School" });
      }
      school.attendance.push({ studentId, status, teacherId });
      await school.save();

      res.json(school);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
}

class Student {
  // 1. View Academic Marks
  static async viewAcademicMarks(req, res) {
    try {
      const { classId } = req.params;

      const school = await School.findOne({ classAssignment: classId });
      if (!school) {
        return res.status(404).json({ msg: "Class not found" });
      }

      res.json({ examResult: school.examResult });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }

  // 2. View Timetable
  static async viewTimetable(req, res) {
    try {
      const { classId } = req.params;

      const school = await School.findOne({ classAssignment: classId });
      if (!school) {
        return res.status(404).json({ msg: "Class not found" });
      }

      res.json(school.timetable);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
}

schoolRouter.post("/api/addFaculty", Admin.addFaculty);
schoolRouter.post("/api/addStudent", Admin.addStudent);
schoolRouter.get("/api/getAllStudents", Admin.getAllStudents);
schoolRouter.get("/api/viewAllTimetables", Admin.viewAllTimetables);
schoolRouter.delete("/api/deleteUserById/:id", Admin.deleteUserById);

schoolRouter.post("/api/addTimetable", Faculty.addTimetable);
schoolRouter.post("/api/addStudentResults", Faculty.addStudentResults);
schoolRouter.post("/api/addAttendance", Faculty.addAttendance);

schoolRouter.get("/api/viewAcademicMarks/:classId", Student.viewAcademicMarks);
schoolRouter.get("/api/viewTimetable/:classId", Student.viewTimetable);

module.exports = schoolRouter;
