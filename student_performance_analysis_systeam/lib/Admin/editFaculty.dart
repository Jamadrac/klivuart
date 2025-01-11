import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:student_analysis/utils/constants.dart';

class EditFacultyActivity extends StatefulWidget {
  final String id;

  EditFacultyActivity({required this.id});

  @override
  _EditFacultyActivityState createState() => _EditFacultyActivityState();
}

class _EditFacultyActivityState extends State<EditFacultyActivity> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    fetchFacultyDetails();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> fetchFacultyDetails() async {
    try {
      final response = await http
          .get(Uri.parse('${Constants.uri}/api/updateUser/${widget.id}'));

      if (response.statusCode == 200) {
        final facultyDetails = jsonDecode(response.body);
        setState(() {
          _nameController.text = facultyDetails['name'];
          _emailController.text = facultyDetails['email'];
        });
      } else {
        throw Exception('Failed to load faculty details: ${response.body}');
      }
    } catch (error) {
      print('Error fetching faculty details: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load faculty details')),
      );
    }
  }

  Future<void> updateFacultyDetails() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedDetails = {
      'name': _nameController.text,
      'email': _emailController.text,
    };

    try {
      final response = await http.put(
        Uri.parse('${Constants.uri}/api/updateUser/${widget.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedDetails),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Faculty details updated successfully!')),
        );
      } else {
        throw Exception('Failed to update faculty details: ${response.body}');
      }
    } catch (error) {
      print('Error updating faculty details: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update faculty details')),
      );
    }
  }

  Future<void> deleteFaculty() async {
    try {
      final response = await http.delete(
        Uri.parse('${Constants.uri}/api/updateUser/${widget.id}'),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Faculty deleted successfully')),
        );
      } else {
        throw Exception('Failed to delete faculty: ${response.body}');
      }
    } catch (error) {
      print('Error deleting faculty: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete faculty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Faculty')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Admin ID: ${widget.id}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateFacultyDetails,
                child: Text('Update Details'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('Confirm Deletion'),
                      content:
                          Text('Are you sure you want to delete this faculty?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            deleteFaculty();
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Delete Faculty'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
