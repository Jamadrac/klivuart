import 'package:flutter/material.dart';
import './Admin/AdminLoginScreen.dart';
import './faculty/FacultyLoginScreen.dart';
import './student/StudentLoginScreen.dart';
import 'xxscreens/signup_screen.dart'; // Ensure you have this file in your project

// ignore: camel_case_types
class Entry_door extends StatelessWidget {
  const Entry_door({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Management',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('School Management'),
          backgroundColor: Colors.purple,
        ),
        body: const Center(
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

  const RoleButton({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          switch (role) {
            case 'ADMIN':
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminLoginScreen()));
              break;
            case 'FACULTY':
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FacultyLoginScreen()));
              break;
            case 'STUDENT':
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StudentLoginScreen()));
              break;
          }
        },
        child: Text(
          role,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignupScreen()));
      },
      child: const Text(
        'SIGN UP',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
