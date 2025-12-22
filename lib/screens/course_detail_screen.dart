import 'package:flutter/material.dart';
import '../theme.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseTitle;

  const CourseDetailScreen({super.key, required this.courseTitle});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(courseTitle),
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Materi"),
              Tab(text: "Tugas Dan Kuis"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Materi Tab
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: ExpansionTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.folder, color: Colors.blue),
                    ),
                    title: Text("Pertemuan ${index + 1}"),
                    subtitle: Text("Konsep Dasar ${index + 1}"),
                    trailing: const Icon(Icons.check_circle, color: kAccentColor),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: const [
                            Icon(Icons.description, color: Colors.grey, size: 20),
                            SizedBox(width: 8),
                            Text("Slide Presentasi.pdf"),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Tugas Tab
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.assignment, color: kPrimaryColor),
                    title: Text("Tugas ${index + 1}"),
                    subtitle: const Text("Tenggat: 25 Des 2024"),
                    trailing: const Chip(
                      label: Text("Aktif"),
                      backgroundColor: Colors.orange,
                      labelStyle: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
