// lib/screens/view_timetable_screen.dart
import 'package:flutter/material.dart';
import '../services/timetable_service.dart';

class ViewTimetableScreen extends StatefulWidget {
  const ViewTimetableScreen({Key? key}) : super(key: key);

  @override
  _ViewTimetableScreenState createState() => _ViewTimetableScreenState();
}

class _ViewTimetableScreenState extends State<ViewTimetableScreen> {
  late Future<List<Timetable>> _timetables;

  @override
  void initState() {
    super.initState();
    _timetables = TimetableService().fetchTimetables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Timetable'),
      ),
      body: FutureBuilder<List<Timetable>>(
        future: _timetables,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No timetables available'));
          } else {
            final timetables = snapshot.data!;
            return ListView.builder(
              itemCount: timetables.length,
              itemBuilder: (context, index) {
                final timetable = timetables[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (timetable.image.isNotEmpty)
                        Container(
                          width: double.infinity,
                          height: 200.0, // Adjust the height as needed
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  MemoryImage(base64ToImage(timetable.image)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      const SizedBox(height: 8.0),
                      Text(
                        timetable.subject,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "Description",
                        semanticsLabel: timetable.description,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
