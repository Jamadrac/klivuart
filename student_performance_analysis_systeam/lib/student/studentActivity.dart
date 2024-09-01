import 'package:flutter/material.dart';
import 'package:student_performance_analysis_systeam/student/NotificationsScreen.dart';
import 'package:student_performance_analysis_systeam/student/sendDoubts.dart';
import 'package:student_performance_analysis_systeam/student/viewQuestionpaper.dart';
import 'package:student_performance_analysis_systeam/student/viewtimtable.dart';

class studentActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Home Activity'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
            //  avigate to another screen
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: Text('View TIME TABLE'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewTimetableScreen()),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: Text('View NOTIFICATIONS'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder:(context)=> NotificationsScreen()));
               
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: Text('Send DOUBTS'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> SenDoubts())
                );
               
              },
            ),
          ],
        ),
      ),
    );
  }
}
