// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

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
  // ignore: library_private_types_in_public_api
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

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _submitTimetable() async {
    if (_formKey.currentState!.validate()) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('YOUR_API_URL_HERE'), // Replace with your API URL
      );
      request.fields['subject'] = subject;
      request.fields['description'] = description;
      if (_image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', _image!.path),
        );
      }

      var response = await request.send();

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
        title: const Text('AddTimeTable'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Subject'),
                onChanged: (value) {
                  setState(() {
                    subject = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
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
