import 'package:flutter/material.dart';
import '../services/paper_service.dart';

class viewQuestionpaper extends StatefulWidget {
  const viewQuestionpaper({Key? key}) : super(key: key);

  @override
  _viewQuestionpaperState createState() => _viewQuestionpaperState();
}

class _viewQuestionpaperState extends State<viewQuestionpaper> {
  late Future<List<Timetable>> _paper;

  @override
  void initState() {
    super.initState();
    _paper = paperervice().fetchpaper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Timetable'),
      ),
      body: FutureBuilder<List<Timetable>>(
        future: _paper,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No paper available'));
          } else {
            final paper = snapshot.data!;
            return ListView.builder(
              itemCount: paper.length,
              itemBuilder: (context, index) {
                final timetable = paper[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Subject:',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          timetable.subject,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Description:',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          timetable.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16.0), // Spacing before image
                        if (timetable.image.isNotEmpty)
                          SizedBox(
                            height: 200.0, // Adjust the height as needed
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.memory(
                                base64ToImage(timetable.image),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                      ],
                    ),
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
