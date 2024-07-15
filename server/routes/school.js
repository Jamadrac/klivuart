// server/routes/school.js


// server/routes/school.js
const express = require("express");
const User = require("../models/user");
const School = require ("../models/school");
const { hash } = require ("bcryptjs"); 


const schoolRouter = express.Router();

   




class Addmin{
//   apis for 
// 1 post: add faculty/ creates a user with type staff
// 2 post: add student creates a user with type student
// 
// 3 get: get all users of type studemt/ 
// 4 get: view all timetables
// 5 get by id delete student or faculty by the id in param


    // 1. Add Faculty
    static async addFaculty(req, res) {
      try {
        const { name, email, password } = req.body;
  
        const existingUser = await User.findOne({ email });
        if (existingUser) {
          return res.status(400).json({ msg: "User with the same email already exists!" });
        }
  
        const hashedPassword = await hash(password, 8);
  
        let user = new User({
          email,
          password: hashedPassword,
          name,
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
        const { name, email, password } = req.body;
  
        const existingUser = await User.findOne({ email });
        if (existingUser) {
          return res.status(400).json({ msg: "User with the same email already exists!" });
        }
  
        const hashedPassword = await hash(password, 8);
  
        let user = new User({
          email,
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
        const timetables = await School.find({}, 'timetable'); // Assuming timetable is a field in the School model
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

     // apis for 
    // 1 add: timetable  string 
    // 2 post: student results (subjects and makes )
    // post addttendance( student id, status {pressent or absent, teacher id STUDENT ID)  }
     
    // 1. Add Timetable
    static async addTimetable(req, res) {
      try {
        const { timetable } = req.body;
  
        let school = await School.findOne();
        if (!school) {
          school = new School({ name: "Default School" });
        }
        school.timetable = timetable;
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
    //  apis for
    //  1 student view accademic marks/collect by class id 
    // 2 view timetable/collect by class id 
    // 
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
  
        res.json({ timetable: school.timetable });
      } catch (e) {
        res.status(500).json({ error: e.message });
      }
    }
  }

  schoolRouter.post("/api/addFaculty", Addmin.addFaculty);
  schoolRouter.post("/api/addStudent", Addmin.addStudent);
  schoolRouter.get("/api/getAllStudents", Addmin.getAllStudents);
  schoolRouter.get("/api/viewAllTimetables", Addmin.viewAllTimetables);
  schoolRouter.delete("/api/deleteUserById/:id", Addmin.deleteUserById);
  
  
  
  
  
  schoolRouter.post("/api/addTimetable", Faculty.addTimetable);
  schoolRouter.post("/api/addStudentResults", Faculty.addStudentResults);
  schoolRouter.post("/api/addAttendance", Faculty.addAttendance);
  
  
  
  schoolRouter.get("/api/viewAcademicMarks/:classId", Student.viewAcademicMarks);
  schoolRouter.get("/api/viewTimetable/:classId", Student.viewTimetable);
  
  
  



  module.exports = schoolRouter;




