import 'package:flutter/material.dart';
import 'dart:async';

import 'package:student_performance_analysis_systeam/Admin/addFaculty.dart';

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
              backgroundColor: Colors.grey,
            ),
            child: Text('ADD FACULTY'),
            onPressed: () {
              // Navigate to another screen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddFacultyActivity()),
              );
            },
          ),
          Expanded(
            child: FutureBuilder<List<String>>(
              future: fetchFacultyList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No faculty found.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index]),
                        onTap: () {
                          // OnClick action - navigate to another screen
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Simulate an API call to fetch faculty list
  Future<List<String>> fetchFacultyList() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Return sample data
    return [
      'Prof. Lokesh B',
      'Prof. Bhavana B',
      // Add more faculty names here
    ];
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: AdminActivity(),
//   ));
// }
