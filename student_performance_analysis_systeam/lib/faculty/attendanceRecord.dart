import 'package:flutter/material.dart';
import './attendee.dart';



class attendanceRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Attendee> attendees = [
    Attendee(name: "John Doe", avatarUrl: "https://via.placeholder.com/150"),
    Attendee(name: "Jane Doe", avatarUrl: "https://via.placeholder.com/150"),
    // Add more attendees as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
      ),
      body: ListView.builder(
        itemCount: attendees.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(attendees[index].avatarUrl),
              ),
              title: Text(attendees[index].name),
          trailing: Container(
  width: 160, // Adjust the width to fit your layout
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _attendanceButton(context, index, true),
      _attendanceButton(context, index, false),
    ],
  ),
),

            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality to submit the attendance data
        },
        child: Icon(Icons.send),
        tooltip: 'Submit Attendance',
      ),
    );
  }

  Widget _attendanceButton(BuildContext context, int index, bool isPresent) {
  return MaterialButton(
    color: attendees[index].isPresent == isPresent ? (isPresent ? Colors.green : Colors.red) : Colors.grey,
    textColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    onPressed: () {
      setState(() {
        for (var attendee in attendees) {
          attendee.isPresent = false; // Reset all to false
        }
        attendees[index].isPresent = isPresent; // Set selected one to true
      });
    },
    child: Text(isPresent ? "Present" : "Absent"),
  );
}

}
