import 'package:flutter/material.dart';
import './attendanceRecord.dart';

class FacultyActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FacultyHomeActivity'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
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
              child: Text('ADD TIME TABLE'),
              onPressed: () {
                // Navigate to another screen
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: Text('RECORD ATTENDANCE'),
              onPressed: () {
                // Navigate to another Attendance
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => attendanceRecord()),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: Text('SEND NOTIFICATIONS'),
              onPressed: () {
                // Navigate to another screen
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: Text('VIEW DOUBTS'),
              onPressed: () {
                // Navigate to another screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
