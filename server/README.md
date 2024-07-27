

### Admin Endpoints

#### 1. Add Faculty
**Endpoint:** `POST /api/addFaculty`

**JSON:**
```json
{
  "name": "John",
  "lastName": "Doe",
  "email": "john.doe@example.com",
  "password": "password123"
}
```

#### 2. Add Student
**Endpoint:** `POST /api/addStudent`

**JSON:**
```json
{
  "name": "Jane",
  "lastName": "Smith",
  "email": "jane.smith@example.com",
  "password": "password123"
}
```

#### 3. Get All Students
**Endpoint:** `GET /api/getAllStudents`

(No JSON payload needed)

#### 4. View All Timetables
**Endpoint:** `GET /api/viewAllTimetables`

(No JSON payload needed)

#### 5. Delete Student or Faculty by ID
**Endpoint:** `DELETE /api/deleteUserById/:id`

(No JSON payload needed; replace `:id` with the actual user ID in the URL)

### Faculty Endpoints

#### 1. Add Timetable
**Endpoint:** `POST /api/addTimetable`

**JSON:**
```json
{
  "timetable": "URL_or_base64_string_of_timetable_image"
}
```

#### 2. Add Student Results
**Endpoint:** `POST /api/addStudentResults`

**JSON:**
```json
{
  "examResult": "URL_or_base64_string_of_exam_result_image"
}
```

#### 3. Add Attendance (attendance.dart)
**Endpoint:** `POST /api/addAttendance`

**JSON:**
```json
{
  "studentId": "student_object_id",
  "status": "present",
  "teacherId": "teacher_object_id"
}
```

### Student Endpoints

#### 1. View Academic Marks (ViewAcademic.dart)
**Endpoint:** `GET /api/viewAcademicMarks/:classId`

(No JSON payload needed; replace `:classId` with the actual class ID in the URL)

#### 2. View Timetable (ViewTimetable)
**Endpoint:** `GET /api/viewTimetable/:classId`

(No JSON payload needed; replace `:classId` with the actual class ID in the URL)

### Example Requests in Postman

**Add Faculty:**
1. Set method to `POST`.
2. Set URL to `http://localhost:5000/api/addFaculty`.
3. Go to the `Body` tab.
4. Select `raw` and choose `JSON` from the dropdown.
5. Paste the JSON payload.

**Get All Students:**
1. Set method to `GET`.
2. Set URL to `http://localhost:5000/api/getAllStudents`.
3. Send the request (no body needed).

.