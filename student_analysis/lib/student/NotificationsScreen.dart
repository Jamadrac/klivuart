import 'dart:convert';

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationsScreen(),
    );
  }
}

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, String>> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
    // Example JSON data
    String jsonString = '''
    [
      {"time": "2024-09-01 08:30", "message": "Meeting with the principal at 10:00 AM."},
      {"time": "2024-09-01 09:00", "message": "Assignment submission deadline is today."},
      {"time": "2024-09-01 09:30", "message": "New update on the school portal."},
      {"time": "2024-09-01 10:00", "message": "Sports day event schedule released."},
      {"time": "2024-09-01 10:30", "message": "Reminder: Parent-teacher meeting tomorrow."},
      {"time": "2024-09-01 11:00", "message": "Science project competition next week."},
      {"time": "2024-09-01 11:30", "message": "Library books return due today."},
      {"time": "2024-09-01 12:00", "message": "Math quiz scheduled for Friday."},
      {"time": "2024-09-01 12:30", "message": "Field trip forms submission deadline extended."},
      {"time": "2024-09-01 13:00", "message": "Music class rescheduled to 2 PM."},
      {"time": "2024-09-01 13:30", "message": "Reminder: Wear sports uniform tomorrow."},
      {"time": "2024-09-01 14:00", "message": "Art competition winners announced."},
      {"time": "2024-09-01 14:30", "message": "School council election results out."},
      {"time": "2024-09-01 15:00", "message": "Drama club meeting at 4 PM."},
      {"time": "2024-09-01 15:30", "message": "Bus schedule changed for tomorrow."},
      {"time": "2024-09-01 16:00", "message": "New cafeteria menu available."},
      {"time": "2024-09-01 16:30", "message": "Student ID cards distribution tomorrow."},
      {"time": "2024-09-01 17:00", "message": "Reminder: Bring extra stationary for exams."},
      {"time": "2024-09-01 17:30", "message": "Library will be closed on Friday."},
      {"time": "2024-09-01 18:00", "message": "New school app update available."}
    ]
    ''';
 
    // Decode JSON
    List<dynamic> jsonData = json.decode(jsonString);

    // Convert to List<Map<String, String>> by ensuring all values are strings
    notifications = jsonData.map((item) {
      return {
        'time': item['time'].toString(),
        'message': item['message'].toString(),
      };
    }).toList();
  }

  void _showFullMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Notification Message"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Text(notifications[index]['time']!),
                subtitle: Text(
                  notifications[index]['message']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => _showFullMessage(notifications[index]['message']!),
              ),
            );
          },
        ),
      ),
    );
  }
}
