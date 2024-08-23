import 'package:flutter/material.dart';
import 'package:student_performance_analysis_systeam/faculty/Add_Questionpaper.dart';
import 'package:student_performance_analysis_systeam/faculty/addTimetable.dart';
import './attendanceRecord.dart';

class FacultyActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FacultyHomeActivity'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Navigate to another screen
            },
          ),
        ],
      ),
      body: Center(
        // Wrap the Column in a Center widget
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceEvenly, // This will space the children evenly
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: const Text('ADD TIME TABLE'),
              onPressed: () {
                // Navigate to another screen
                // Navigate to another screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const AddTimeTableActivity()),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: const Text('RECORD ATTENDANCE'),
              onPressed: () {
                // Navigate to another Attendance
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AttendanceRecord()),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: const Text('SEND NOTIFICATIONS'),
              onPressed: () {
                // Navigate to another screen
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: const Text('VIEW DOUBTS'),
              onPressed: () {
                // Navigate to another screen
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: const Text('ADD QUESTION PAPERS'),
              onPressed: () {
                 Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Add_Questionpaper()),
                );
                  },
            ),

          ],
        ),
      ),
    );
  }
}
