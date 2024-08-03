import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Faculty',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: AddFacultyActivity(),
    );
  }
}

class AddFacultyActivity extends StatefulWidget {
  @override
  _AddFacultyActivityState createState() => _AddFacultyActivityState();
}

class _AddFacultyActivityState extends State<AddFacultyActivity> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String mobile = '';
  String email = '';
  String department = '';
  String username = '';
  String password = '';

  Future<void> _registerFaculty() async {
    final response = await http.post(
      Uri.parse('YOUR_API_URL_HERE'), // Replace with your API URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'mobile': mobile,
        'email': email,
        'department': department,
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Faculty registered successfully!')),
      );
    } else {
      // If the server did not return a 200 OK response
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register faculty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddFacultyActivity'),
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
                decoration: InputDecoration(labelText: 'Mobile'),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  setState(() {
                    mobile = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    email = value;
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
                decoration: InputDecoration(labelText: 'User name'),
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _registerFaculty();
                  }
                },
                child: Text('ADD'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
