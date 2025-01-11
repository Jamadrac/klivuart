// lib/services/timetable_service.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:student_analysis/utils/constants.dart';

// Model for Timetable
class Timetable {
  final String subject;
  final String description;
  final String image;

  Timetable({
    required this.subject,
    required this.description,
    required this.image,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      subject: json['subject'],
      description: json['description'],
      image: json['image'],
    );
  }
}

// Service for fetching timetable data
class TimetableService {
  // static const String baseUrls = Constants.uri;

  Future<List<Timetable>> fetchTimetables() async {
    final response =
        await http.get(Uri.parse('${Constants.uri}/api/viewAllTimetables'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Timetable.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load timetables');
    }
  }
}

// Utility function to convert Base64 to Uint8List
Uint8List base64ToImage(String base64String) {
  // Remove the data URL prefix if present
  final base64Image =
      base64String.replaceAll(RegExp(r'^data:image\/[^;]+;base64,'), '');
  return base64Decode(base64Image);
}
