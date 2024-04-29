import './studentActivity.dart';
import 'package:flutter/material.dart';

class StudentLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Login'),
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
                  MaterialPageRoute(builder: (context) => studentActivity()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                minimumSize: Size.fromHeight(50), // makes it easier to tap
              ),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
