
import 'package:flutter/material.dart';
import './Admin/AdminLoginScreen.dart';
import './faculty/FacultyLoginScreen.dart';
import './student/StudentLoginScreen.dart';

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
