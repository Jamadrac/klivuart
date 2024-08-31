const express = require("express");
const User = require("../models/user");
const School = require("../models/school");
const Attendance = require('../models/attendance.js');
const Timetable = require("../models/timetable");
const { hash } = require("bcryptjs");
const add_questionPapers = require('../models/add_questionPapers.js')

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
      const students = await User.find({ userType: 'student' });
      res.json(students);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }

  // 4. View All Timetables
  static async viewAllTimetables(req, res) {
    try {
      const timetables = await Timetable.find();
      if (!timetables.length) {
        return res.status(404).json({ msg: "No timetables found" });
      }

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

  // 6. Get Faculty Details by ID
  static async getFacultyById(req, res) {
    try {
      const { id } = req.params;
      const user = await User.findById(id);
      
      if (!user || user.userType !== "staff") {
        return res.status(404).json({ msg: "Faculty not found" });
      }

      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }

  // 7. Update Faculty Details by ID
  static async updateFacultyById(req, res) {
    try {
      const { id } = req.params;
      const { name, email } = req.body;

      const user = await User.findById(id);
      if (!user || user.userType !== "staff") {
        return res.status(404).json({ msg: "Faculty not found" });
      }

      user.name = name;
      user.email = email;
      await user.save();

      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }

  // 8. Delete Faculty by ID
  static async deleteFacultyById(req, res) {
    try {
      const { id } = req.params;
      const user = await User.findByIdAndDelete(id);

      if (!user || user.userType !== "staff") {
        return res.status(404).json({ msg: "Faculty not found" });
      }

      res.json({ msg: "Faculty deleted successfully" });
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
      console.log(`Request Body: ${JSON.stringify(req.body)}`);

      // Create a new timetable entry
      const timetableEntry = new Timetable({
        subject,
        description,
        image,
      });

      // Save the new timetable entry to the database
      await timetableEntry.save();

      // Respond with a success message
      res.json({ msg: "Timetable entry added successfully." });
    } catch (e) {
      console.error(`Error: ${e.message}`);
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

  // 3. Delete Timetable
  static async deleteTimetable(req, res) {
    try {
      const { id } = req.params;
      const result = await Timetable.findByIdAndDelete(id);

      if (!result) {
        return res.status(404).json({ msg: "Timetable entry not found" });
      }

      res.json({ msg: "Timetable entry deleted successfully" });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
// // xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

 // 1. Add questionPapers
  static async add_questionPapers(req, res) {
    try {
      const { subject, description, image } = req.body;
      console.log(`Request Body: ${JSON.stringify(req.body)}`);

      // Create a new timetable entry
      const add_questionPapersEntry = new add_questionPapers({
        subject,
        description,
        image,
      });

      // Save the new timetable entry to the database
      await add_questionPapersEntry.save();

      // Respond with a success message
      res.json({ msg: "Timetable entry added successfully." });
    } catch (e) {
      console.error(`Error: ${e.message}`);
      res.status(500).json({ error: e.message });
    }
  }

//   // 2. Add Student Results
//   static async addStudentResults(req, res) {
//     try {
//       const { examResult } = req.body;

//       let school = await School.findOne();
//       if (!school) {
//         school = new School({ name: "Default School" });
//       }
//       school.examResult = examResult;
//       await school.save();

//       res.json(school);
//     } catch (e) {
//       res.status(500).json({ error: e.message });
//     }
//   }

//   // 3. Delete Timetable
//   static async deleteTimetable(req, res) {
//     try {
//       const { id } = req.params;
//       const result = await Timetable.findByIdAndDelete(id);

//       if (!result) {
//         return res.status(404).json({ msg: "Timetable entry not found" });
//       }

//       res.json({ msg: "Timetable entry deleted successfully" });
//     } catch (e) {
//       res.status(500).json({ error: e.message });
//     }
//   }
// // xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx












































//  // 1. Add add_questionPapers
//  static async addadd_questionPapers(req, res) {
//   try {
//     const { subject, description, image } = req.body;
//     console.log(`Request Body: ${JSON.stringify(req.body)}`);

//     // Create a new add_questionPapers entry
//     const add_questionPapersEntry = new add_questionPapers({
//       subject,
//       description,
//       image,
//     });

//     // Save the new add_questionPapers entry to the database
//     await add_questionPapersEntry.save();

//     // Respond with a success message
//     res.json({ msg: "add_questionPapers entry added successfully." });
//   } catch (e) {
//     console.error(`Error: ${e.message}`);
//     res.status(500).json({ error: e.message });
//   }
// }

// // 2. Add Student Results
// static async addStudentResults(req, res) {
//   try {
//     const { examResult } = req.body;

//     let school = await School.findOne();
//     if (!school) {
//       school = new School({ name: "Default School" });
//     }
//     school.examResult = examResult;
//     await school.save();

//     res.json(school);
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// }

// // 3. Delete add_questionPapers
// static async deleteadd_questionPapers(req, res) {
//   try {
//     const { id } = req.params;
//     const result = await add_questionPapers.findByIdAndDelete(id);

//     if (!result) {
//       return res.status(404).json({ msg: "add_questionPapers entry not found" });
//     }

//     res.json({ msg: "add_questionPapers entry deleted successfully" });
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// }


















// // xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx






  // 4. Add Attendance
  static async addAttendance(req, res) {
    const { presentIds, absentIds, teacherEmail } = req.body;
    try {
      // Validate the presence of required fields
      if (!presentIds || !absentIds || !teacherEmail) {
        return res.status(400).json({ message: "Missing required fields" });
      }

      // Create and save attendance records for present students
      for (const studentId of presentIds) {
        await new Attendance({
          studentId,
          status: 'present',
          teacherEmail,
        }).save();
      }

      // Create and save attendance records for absent students
      for (const studentId of absentIds) {
        await new Attendance({
          studentId,
          status: 'absent',
          teacherEmail,
        }).save();
      }

      res.status(201).json({ message: "Attendance recorded successfully!" });
    } catch (error) {
      console.error(`Error recording attendance: ${error.message}`);
      res.status(500).json({ message: "Failed to record attendance", error: error.message });
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
      const timetables = await Timetable.find(); // Retrieve all timetables

      if (!timetables.length) {
        return res.status(404).json({ msg: "No timetables found" });
      }

      res.json(timetables);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
}

// Routes
schoolRouter.post("/api/addFaculty", Admin.addFaculty);
schoolRouter.post("/api/addStudent", Admin.addStudent);
schoolRouter.get("/api/getAllStudents", Admin.getAllStudents);
schoolRouter.get("/api/viewAllTimetables", Admin.viewAllTimetables);
schoolRouter.delete("/api/deleteUserById/:id", Admin.deleteUserById);

schoolRouter.get("/api/faculty/:id", Admin.getFacultyById);
schoolRouter.put("/api/faculty/:id", Admin.updateFacultyById);
schoolRouter.delete("/api/faculty/:id", Admin.deleteFacultyById);

schoolRouter.post("/api/addTimetable", Faculty.addTimetable);
schoolRouter.post("/api/addStudentResults", Faculty.addStudentResults);
schoolRouter.post("/api/attendance", Faculty.addAttendance);

schoolRouter.get("/api/viewAcademicMarks/:classId", Student.viewAcademicMarks);
schoolRouter.get("/api/viewTimetable", Student.viewTimetable);


// schoolRouter.get("/api/viewTimetable", Student.addadd_questionPapers);
schoolRouter.post("/api/add_questionPapers", Faculty.add_questionPapers);

module.exports = schoolRouter;
