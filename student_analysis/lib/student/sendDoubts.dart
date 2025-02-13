import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constants.dart';
import '../utils/utils.dart';

class SenDoubts extends StatefulWidget {
  const SenDoubts({super.key});

  @override
  _SenDoubtsState createState() => _SenDoubtsState();
}

class _SenDoubtsState extends State<SenDoubts> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _statementController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _statementController.dispose();
    super.dispose();
  }

  void submitDoubt(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    if (_subjectController.text.isEmpty || _statementController.text.isEmpty) {
      showSnackBar(context, 'Please fill out all fields');
      return;
    }

    try {
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/doubts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
        body: jsonEncode({
          'email': user.email, // Changed from 'name' to 'email'
          'subject': _subjectController.text,
          'statement': _statementController.text,
        }),
      );

      if (res.statusCode == 200) {
        showSnackBar(context, 'Doubt submitted successfully');
      } else {
        throw Exception('Failed to submit doubt: ${res.body}');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Send Doubts')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student: ${user.email}', // Changed from user.name to user.email
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _statementController,
              decoration: InputDecoration(
                labelText: 'Statement',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => submitDoubt(context),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
