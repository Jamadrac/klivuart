import 'package:flutter/material.dart';
import './Admin/AdminLoginScreen.dart';
import './faculty/FacultyLoginScreen.dart';
import './student/StudentLoginScreen.dart';
import './screens/signup_screen.dart';  // Ensure you have this file in your project

class Entry_door extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Management',
      home: Scaffold(
        appBar: AppBar(
          title: Text('School Management'),
          backgroundColor: Colors.purple,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoleButton(role: 'ADMIN'),
              RoleButton(role: 'FACULTY'),
              RoleButton(role: 'STUDENT'),
              SizedBox(height: 20), // Adds space between buttons
              SignupButton(), // Button for navigating to the signup screen
            ],
          ),
        ),
      ),
    );
  }
}

class RoleButton extends StatelessWidget {
  final String role;

  RoleButton({required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          shadowColor: Colors.black,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          switch (role) {
            case 'ADMIN':
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLoginScreen()));
              break;
            case 'FACULTY':
              Navigator.push(context, MaterialPageRoute(builder: (context) => FacultyLoginScreen()));
              break;
            case 'STUDENT':
              Navigator.push(context, MaterialPageRoute(builder: (context) => StudentLoginScreen()));
              break;
          }
        },
        child: Text(
          role,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
      },
      child: Text(
        'SIGN UP',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
