import 'package:flutter/material.dart';
import '../theme.dart';
import 'session_detail_screen.dart';

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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SessionDetailScreen(
                            sessionTitle: "Pertemuan ${index + 1}: Konsep Dasar ${index + 1}",
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12), // Match card shape
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.folder, color: Colors.blue),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pertemuan ${index + 1}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Konsep Dasar ${index + 1}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.check_circle, color: kAccentColor),
                        ],
                      ),
                    ),
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
