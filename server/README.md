          API Documentation
1. Admin Routes
Add Faculty
Endpoint
POST http://localhost:5000/api/addFaculty
Payload:

json
Copy code
{
  "name": "John Doe",
  "email": "john.doe@example.com",
  "password": "password123"
}
Response:
A newly created faculty user
json
Copy code
{
  "_id": "60d...2c",
  "email": "john.doe@example.com",
  "password": "$2a$08$...",
  "name": "John Doe",
  "userType": "staff",
  "__v": 0
}





Add Student
Endpoint
POST http://localhost:5000/api/addStudent
Payload:

json
Copy code
{
  "name": "Jane Doe",
  "email": "jane.doe@example.com",
  "password": "password123"
}
Response:
A newly created student user
json
Copy code
{
  "_id": "60d...2c",
  "email": "jane.doe@example.com",
  "password": "$2a$08$...",
  "name": "Jane Doe",
  "userType": "student",
  "__v": 0
}


Get All Students
Endpoint
GET http://localhost:5000/api/getAllStudents
Response:
An array of student users
json
Copy code
[
  {
    "_id": "60d...2c",
    "email": "jane.doe@example.com",
    "password": "$2a$08$...",
    "name": "Jane Doe",
    "userType": "student",
    "__v": 0
  },
  {
    "_id": "60d...3d",
    "email": "john.doe@example.com",
    "password": "$2a$08$...",
    "name": "John Doe",
    "userType": "student",
    "__v": 0
  }
]
View All Timetables
Endpoint
GET http://localhost:5000/api/viewAllTimetables
Response:
An array of timetables
json
Copy code
[
  {
    "_id": "60d...4e",
    "timetable": "URL_OR_BASE64_STRING_OF_TIMETABLE_IMAGE"
  }
]
Delete User by ID
Endpoint
DELETE http://localhost:5000/api/deleteUserById/:id
Parameters:

id: User ID to be deleted
Response:
Confirmation of user deletion
json
Copy code
{
  "msg": "User deleted successfully"
}
2. Faculty Routes
Add Timetable
Endpoint
POST http://localhost:5000/api/addTimetable
Payload:

json
Copy code
{
  "timetable": "URL_OR_BASE64_STRING_OF_TIMETABLE_IMAGE"
}
Response:
The updated school document with the new timetable
json
Copy code
{
  "_id": "60d...4e",
  "name": "Default School",
  "timetable": "URL_OR_BASE64_STRING_OF_TIMETABLE_IMAGE",
  "__v": 0
}
Add Student Results
Endpoint
POST http://localhost:5000/api/addStudentResults
Payload:

json
Copy code
{
  "examResult": "URL_OR_BASE64_STRING_OF_EXAM_RESULT_IMAGE"
}
Response:
The updated school document with the new exam results
json
Copy code
{
  "_id": "60d...4e",
  "name": "Default School",
  "examResult": "URL_OR_BASE64_STRING_OF_EXAM_RESULT_IMAGE",
  "__v": 0
}
Add Attendance
Endpoint
POST http://localhost:5000/api/addAttendance
Payload:

json
Copy code
{
  "studentId": "STUDENT_ID",
  "status": "present",
  "teacherId": "TEACHER_ID"
}
Response:
The updated school document with the new attendance record
json
Copy code
{
  "_id": "60d...4e",
  "name": "Default School",
  "attendance": [
    {
      "studentId": "STUDENT_ID",
      "status": "present",
      "teacherId": "TEACHER_ID"
    }
  ],
  "__v": 0
}
3. Student Routes
View Academic Marks
Endpoint
GET http://localhost:5000/api/viewAcademicMarks/:classId
Parameters:

classId: Class ID to filter marks by
Response:
An array of academic marks for the specified class
json
Copy code
[
  {
    "subject": "Mathematics",
    "marks": 85
  },
  {
    "subject": "Science",
    "marks": 90
  }
]
View Timetable
Endpoint
GET http://localhost:5000/api/viewTimetable/:classId
Parameters:

classId: Class ID to filter timetable by
Response:
The timetable for the specified class
json
Copy code
{
  "classId": "CLASS_ID",
  "timetable": "URL_OR_BASE64_STRING_OF_TIMETABLE_IMAGE"
}
