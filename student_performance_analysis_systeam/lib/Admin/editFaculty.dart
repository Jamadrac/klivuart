import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:student_performance_analysis_systeam/utils/constants.dart';

class EditFacultyActivity extends StatelessWidget {
  final String id;

  EditFacultyActivity({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Faculty'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchFacultyDetails(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No details found.'));
          } else {
            final data = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${data['name']}', style: TextStyle(fontSize: 18)),
                  // Add other fields and widgets as needed
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchFacultyDetails(String id) async {
    final response =
        await http.get(Uri.parse('${Constants.uri}/api/updateUser/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      var res;
      throw Exception('Failed to load faculty details: ${res.body}');
    }
  }
}
