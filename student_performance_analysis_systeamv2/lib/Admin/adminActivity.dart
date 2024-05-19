import 'package:flutter/material.dart';

class AdminActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdminHomeActivity'),
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
            child: Text('ADD FACULTY'),
            onPressed: () {
              // Navigate to another screen
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: facultyList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(facultyList[index]),
                  onTap: () {
                    // OnClick action - navigate to another screen
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Sample list of faculty names
  final List<String> facultyList = [
    'Prof. Lokesh B',
    'Prof. Bhavana B',
    // Add more faculty names here
  ];
}
