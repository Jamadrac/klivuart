import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_analysis/utils/constants.dart';

void main() => runApp(AttendanceRecord());

class AttendanceRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(primarySwatch: Colors.blue),
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
  bool _isLoading = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _fetchAttendees();
  }

  Future<void> _fetchAttendees() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('${Constants.uri}/api/getAllStudents'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          attendees = data.map((json) => Attendee.fromJson(json)).toList();
        });
      } else {
        print('Failed to load attendees');
      }
    } catch (e) {
      print('Error fetching attendees: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _postAttendance() async {
    setState(() {
      _isSubmitting = true; // Set submitting to true
    });

    try {
      final presentIds = attendees
          .where((attendee) => attendee.isPresent)
          .map((attendee) => attendee.id)
          .toList();
      final absentIds = attendees
          .where((attendee) => !attendee.isPresent)
          .map((attendee) => attendee.id)
          .toList();
      final response = await http.post(
        Uri.parse('${Constants.uri}/api/attendance'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'presentIds': presentIds,
          'absentIds': absentIds,
          'teacherEmail': 'johndoe@example.com',
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Attendance recorded successfully!')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to record attendance')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error posting attendance: $e')));
    } finally {
      setState(() {
        _isSubmitting = false; // Set submitting to false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : attendees.isEmpty
              ? Center(child: Text('No attendees found'))
              : ListView.builder(
                  itemCount: attendees.length,
                  itemBuilder: (context, index) {
                    final attendee = attendees[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: _buildAvatar(attendee),
                        title: Text(attendee.name),
                        subtitle: Text('${attendee.email}'),
                        trailing: Container(
                          width: MediaQuery.of(context).size.width *
                              0.4, // Adjust width dynamically
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: _attendanceButton(context, index, true),
                              ),
                              Expanded(
                                child: _attendanceButton(context, index, false),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _isSubmitting ? null : _postAttendance, // Disable when submitting
        child: _isSubmitting
            ? CircularProgressIndicator(color: Colors.white)
            : Icon(Icons.send),
        tooltip: 'Submit Attendance',
      ),
    );
  }

  Widget _buildAvatar(Attendee attendee) {
    return CircleAvatar(
      backgroundColor: Colors.grey[200],
      child: attendee.avatarUrl != null && attendee.avatarUrl!.isNotEmpty
          ? ClipOval(
              child: Image.network(
                attendee.avatarUrl!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.person, size: 40);
                },
              ),
            )
          : Icon(Icons.person, size: 40),
    );
  }

  Widget _attendanceButton(BuildContext context, int index, bool isPresent) {
    return MaterialButton(
      color: attendees[index].isPresent == isPresent
          ? (isPresent ? Colors.green : Colors.red)
          : Colors.grey,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () {
        setState(() {
          attendees[index].isPresent = isPresent; // Set selected one to true
        });
      },
      child: Text(isPresent ? "Present" : "Absent"),
    );
  }
}

class Attendee {
  final String id;
  final String name;
  final String? avatarUrl; // Nullable
  final String lastName;
  final String email;
  final int? age;
  final String? bloodType;
  final String? studentClass;
  final String? department;
  final String? sex;
  bool isPresent;

  Attendee({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.lastName,
    required this.email,
    this.age,
    this.bloodType,
    this.studentClass,
    this.department,
    this.sex,
    this.isPresent = false,
  });

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      id: json['_id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      age: json['age'],
      bloodType: json['bloodType'],
      studentClass: json['class'],
      department: json['department'],
      sex: json['sex'],
    );
  }
}
