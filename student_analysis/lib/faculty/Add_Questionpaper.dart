import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../utils/constants.dart';

class Add_Questionpaper extends StatefulWidget {
  const Add_Questionpaper({super.key});

  @override
  _Add_QuestionpaperState createState() => _Add_QuestionpaperState();
}

class _Add_QuestionpaperState extends State<Add_Questionpaper> {
  final _formKey = GlobalKey<FormState>();
  String subject = '';
  String description = '';
  File? _image;

  Future<void> _chooseImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(
          pickedFile.path,
        ); // Create a File object from the pickedFile path
      });
    }
  }

  Future<void> _submitTimetable() async {
    if (_formKey.currentState!.validate()) {
      final imageBytes =
          _image != null ? base64Encode(await _image!.readAsBytes()) : '';

      var response = await http.post(
        Uri.parse('${Constants.uri}/api/question_paper'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'subject': subject,
          'description': description,
          'image': imageBytes,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('question papers submitted successfully!'),
          ),
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
      appBar: AppBar(title: const Text('Add a question paper')),
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
