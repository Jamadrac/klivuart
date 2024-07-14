// server/routes/school.js


// server/routes/school.js
import express from "express";
import User from "../models/user";
import School from "../models/school";
import { hash } from "bcryptjs"; // Import hash function

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



  
  
  schoolRouter.post("/api/addFaculty", Admin.addFaculty);
  schoolRouter.post("/api/addStudent", Admin.addStudent);
  schoolRouter.get("/api/getAllStudents", Admin.getAllStudents);
  schoolRouter.get("/api/viewAllTimetables", Admin.viewAllTimetables);
  schoolRouter.delete("/api/deleteUserById/:id", Admin.deleteUserById);
  
  export default schoolRouter;




class Faculty{ 
    // apis for 
    // 1 add: timetable  string 
    // 2 post: student results (subjects and makes )
    // post addttendance( student id, status {pressent or absent, teacher id STUDENT ID)  }
     
}

class student {
    //  apis for
    //  1 student view accademic marks/collect by class id 
    // 2 view timetable/collect by class id 
    // 

}

