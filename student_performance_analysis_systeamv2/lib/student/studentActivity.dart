import 'package:flutter/material.dart';

class studentActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('studentHomeActivity'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Navigate to another screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
            ),
            child: Text('view TIME TABLE'),
            onPressed: () {
              // Navigate to another screen
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
            ),
            child: Text('view NOTIFICATIONS'),
            onPressed: () {
              // Navigate to another screen
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
            ),
            child: Text('send DOUBTS'),
            onPressed: () {
              // Navigate to another screen
            },
          ),
        ],
      ),
    );
  }
}
