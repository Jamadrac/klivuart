// doubts_list_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:student_analysis/student/sendDoubts.dart';
import 'package:student_analysis/utils/constants.dart';

class DoubtsListScreen extends StatefulWidget {
  @override
  _DoubtsListScreenState createState() => _DoubtsListScreenState();
}

class _DoubtsListScreenState extends State<DoubtsListScreen> {
  List<dynamic> doubts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDoubts();
  }

  Future<void> fetchDoubts() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(Uri.parse('${Constants.uri}/api/doubts'));
      if (response.statusCode == 200) {
        setState(() {
          doubts = json.decode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load doubts: $e')));
    }
  }

  Future<void> deleteDoubt(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://localhost:8000/api/doubts/$id'),
      );
      if (response.statusCode == 200) {
        setState(() {
          doubts.removeWhere((doubt) => doubt['_id'] == id);
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Doubt deleted successfully')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to delete doubt: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Doubts'),
        backgroundColor: Colors.blue,
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: fetchDoubts,
                child:
                    doubts.isEmpty
                        ? Center(child: Text('No doubts found'))
                        : ListView.builder(
                          itemCount: doubts.length,
                          itemBuilder: (context, index) {
                            final doubt = doubts[index];
                            return Card(
                              margin: EdgeInsets.all(8),
                              child: ListTile(
                                title: Text(doubt['statement'] ?? ''),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Subject: ${doubt['subject'] ?? ''}'),
                                    Text(
                                      'Student: ${doubt['studentName'] ?? ''}',
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed:
                                      () => showDialog(
                                        context: context,
                                        builder:
                                            (context) => AlertDialog(
                                              title: Text('Delete Doubt'),
                                              content: Text(
                                                'Are you sure you want to delete this doubt?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text('Cancel'),
                                                  onPressed:
                                                      () => Navigator.pop(
                                                        context,
                                                      ),
                                                ),
                                                TextButton(
                                                  child: Text('Delete'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    deleteDoubt(doubt['_id']);
                                                  },
                                                ),
                                              ],
                                            ),
                                      ),
                                ),
                              ),
                            );
                          },
                        ),
              ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SenDoubts()),
          );
          if (result == true) {
            fetchDoubts();
          }
        },
      ),
    );
  }
}
