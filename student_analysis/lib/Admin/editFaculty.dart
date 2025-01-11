import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/constants.dart';

class EditFacultyActivity extends StatefulWidget {
  final String id;
  EditFacultyActivity({required this.id});

  @override
  _EditFacultyActivityState createState() => _EditFacultyActivityState();
}

class _EditFacultyActivityState extends State<EditFacultyActivity> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  bool _isLoading = true;
  Map<String, dynamic> _currentDetails = {};

  // Controllers for all possible fields in the model
  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'mobile': TextEditingController(),
    'department': TextEditingController(),
    'userType': TextEditingController(),
    'age': TextEditingController(),
    'bloodType': TextEditingController(),
    'class': TextEditingController(),
    'sex': TextEditingController(),
  };

  get id => null;

  @override
  void initState() {
    super.initState();
    fetchCurrentDetails();
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  Future<void> fetchCurrentDetails() async {
    try {
      setState(() => _isLoading = true);

      // Get current user details
      final response = await http.get(
        Uri.parse('${Constants.uri}/api/users/${widget.id}'),
      );

      if (response.statusCode == 200) {
        final details = jsonDecode(response.body);
        setState(() {
          _currentDetails = details;

          // Update all controllers with current values if they exist
          _controllers.forEach((field, controller) {
            if (details[field] != null) {
              controller.text = details[field].toString();
            }
          });
        });

        print(
          'Current Detailsxxxxxxxxxxxxxxxxxxxxx: $_currentDetails',
        ); // Debug print
      } else {
        throw Exception('Failed to load user details: ${response.body}');
      }
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading details: $error')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> updateUserDetails() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() => _isLoading = true);

      // Collect all current values from controllers
      final updatedDetails = {};
      _controllers.forEach((field, controller) {
        if (controller.text.isNotEmpty) {
          updatedDetails[field] = controller.text;
        }
      });

      print('Updating with details: $updatedDetails  $id'); // Debug print

      final response = await http.put(
        Uri.parse('${Constants.uri}/api/updateUser/${widget.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedDetails),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Details updated successfully!')),
        );
        setState(() => _isEditing = false);
        fetchCurrentDetails(); // Refresh the data
      } else {
        throw Exception('Failed to update: ${response.body}');
      }
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Update failed: $error')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildField(
    String label,
    String field, {
    TextInputType? keyboardType,
  }) {
    final currentValue = _currentDetails[field]?.toString() ?? '';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _controllers[field],
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
              enabled: _isEditing,
              helperText: _isEditing ? 'Current: $currentValue' : null,
            ),
            keyboardType: keyboardType,
            validator: (value) {
              if (field == 'email' &&
                  value!.isNotEmpty &&
                  !value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => setState(() => _isEditing = true),
            ),
        ],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ID: ${widget.id}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 20),
                              _buildField('Name', 'name'),
                              _buildField('Email', 'email'),
                              _buildField('Mobile', 'mobile'),
                              _buildField('Department', 'department'),
                              _buildField('User Type', 'userType'),
                              _buildField(
                                'Age',
                                'age',
                                keyboardType: TextInputType.number,
                              ),
                              _buildField('Blood Type', 'bloodType'),
                              _buildField('Class', 'class'),
                              _buildField('Sex', 'sex'),

                              if (_isEditing) ...[
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: updateUserDetails,
                                  child: Text('Save Changes'),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    minimumSize: Size(double.infinity, 50),
                                  ),
                                ),
                                SizedBox(height: 8),
                                TextButton(
                                  onPressed: () {
                                    setState(() => _isEditing = false);
                                    fetchCurrentDetails(); // Reset to current values
                                  },
                                  child: Text('Cancel'),
                                  style: TextButton.styleFrom(
                                    minimumSize: Size(double.infinity, 50),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
