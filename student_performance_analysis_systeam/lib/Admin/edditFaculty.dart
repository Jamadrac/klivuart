import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class edditFaculty extends StatefulWidget {
  final String userId;

  edditFaculty({required this.userId});

  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<edditFaculty> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String userType = '';
  String age = '';
  String bloodType = '';
  String userClass = '';
  String department = '';
  String sex = '';

  Future<void> _updateUserDetails() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.put(
        Uri.parse(
            'YOUR_API_URL_HERE/api/updateUser/${widget.userId}'), // Replace with your API URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'userType': userType,
          'age': age,
          'bloodType': bloodType,
          'class': userClass,
          'department': department,
          'sex': sex,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user: ${response.body}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Type'),
                onChanged: (value) {
                  setState(() {
                    userType = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                onChanged: (value) {
                  setState(() {
                    age = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Blood Type'),
                onChanged: (value) {
                  setState(() {
                    bloodType = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Class'),
                onChanged: (value) {
                  setState(() {
                    userClass = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Department'),
                onChanged: (value) {
                  setState(() {
                    department = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sex'),
                onChanged: (value) {
                  setState(() {
                    sex = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateUserDetails,
                child: Text('UPDATE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: edditFaculty(
      userId: 'YOUR_USER_ID_HERE', // Replace with your user ID
    ),
  ));
}
