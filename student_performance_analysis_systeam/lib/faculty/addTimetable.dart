import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:student_performance_analysis_systeam/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Timetable',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const AddTimeTableActivity(),
    );
  }
}

class AddTimeTableActivity extends StatefulWidget {
  const AddTimeTableActivity({super.key});

  @override
  _AddTimeTableActivityState createState() => _AddTimeTableActivityState();
}

class _AddTimeTableActivityState extends State<AddTimeTableActivity> {
  final _formKey = GlobalKey<FormState>();
  String subject = '';
  String description = '';
  File? _image;

  Future<void> _chooseImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(
            pickedFile.path); // Create a File object from the pickedFile path
      });
    }
  }

  Future<void> _submitTimetable() async {
    if (_formKey.currentState!.validate()) {
      final imageBytes =
          _image != null ? base64Encode(await _image!.readAsBytes()) : '';

      var response = await http.post(
        Uri.parse(
            '${Constants.uri}/api/addTimetable'), // Replace with your API URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'subject': subject,
          'description': description,
          'image': imageBytes,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Timetable submitted successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit timetable')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Timetable'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    subject = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _chooseImage,
                child: const Text('CHOOSE IMAGE'),
              ),
              _image != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Image.file(
                        _image!,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover, // Ensure the image fits correctly
                      ),
                    )
                  : Container(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitTimetable,
                child: const Text('SUBMIT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
