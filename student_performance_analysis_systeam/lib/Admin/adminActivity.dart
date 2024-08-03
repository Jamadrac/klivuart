import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:student_performance_analysis_systeam/Admin/addFaculty.dart'; // For decoding JSON response
import 'package:student_performance_analysis_systeam/Admin/editFaculty.dart';
import 'package:student_performance_analysis_systeam/utils/constants.dart'; // Import the EditFacultyActivity

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
              // Navigate to another screen if needed
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
              // Navigate to add faculty screen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddFacultyActivity()),
              );
            },
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
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
                      final item = snapshot.data![index];
                      return ListTile(
                        title: Text(item['name']),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditFacultyActivity(id: item['id']),
                            ),
                          );
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

  // Fetch the list of faculty from the API
  Future<List<Map<String, dynamic>>> fetchFacultyList() async {
    final response = await http.get(Uri.parse('${Constants.uri}/api/admins'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      // Extract names and IDs
      return data
          .map((item) => {
                'id': item['_id'],
                'name': item['name'],
              })
          .toList();
    } else {
      throw Exception('Failed to load faculty');
    }
  }
}
