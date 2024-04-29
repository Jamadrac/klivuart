import './faculActivity.dart';

import 'package:flutter/material.dart';

class FacultyLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty Login'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle login logic here
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FacultyActivity()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                minimumSize: Size.fromHeight(50),
              ),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
