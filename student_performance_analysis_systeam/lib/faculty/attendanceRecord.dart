import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_performance_analysis_systeam/utils/constants.dart';

void main() => runApp(AttendanceRecord());

class AttendanceRecord extends StatelessWidget {
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
  List<Attendee> attendees = [];

  @override
  void initState() {
    super.initState();
    _fetchAttendees();
  }

  Future<void> _fetchAttendees() async {
    try {
      final response =
          await http.get(Uri.parse('${Constants.uri}/api/getAllStudents'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          attendees = data.map((json) => Attendee.fromJson(json)).toList();
        });
      } else {
        // Handle errors
        print('Failed to load attendees');
      }
    } catch (e) {
      print('Error fetching attendees: $e');
    }
  }

  Future<void> _postAttendance(String studentId, bool isPresent) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.uri}/api/attendance'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'studentId': studentId,
          'status': isPresent ? 'present' : 'absent',
          'teacherEmail':
              'teacher@example.com', // Replace with dynamic email if needed
        }),
      );
      if (response.statusCode == 201) {
        print('Attendance recorded successfully!');
      } else {
        // Handle errors
        print('Failed to record attendance');
      }
    } catch (e) {
      print('Error posting attendance: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
      ),
      body: attendees.isEmpty
          ? Center(child: Text('No attendees found'))
          : ListView.builder(
              itemCount: attendees.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(attendees[index].avatarUrl),
                      onBackgroundImageError: (_, __) => Icon(Icons.person),
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
      color: attendees[index].isPresent == isPresent
          ? (isPresent ? Colors.green : Colors.red)
          : Colors.grey,
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
        _postAttendance(attendees[index].id, isPresent);
      },
      child: Text(isPresent ? "Present" : "Absent"),
    );
  }
}

class Attendee {
  final String id;
  final String name;
  final String avatarUrl;
  bool isPresent;

  Attendee({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isPresent = false,
  });

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      id: json['_id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
    );
  }
}
