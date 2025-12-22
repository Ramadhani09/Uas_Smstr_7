import 'package:flutter/material.dart';
import '../widgets/course_card.dart';
import 'course_detail_screen.dart';

class MyClassesScreen extends StatelessWidget {
  const MyClassesScreen({super.key});

  final List<Map<String, dynamic>> classes = const [
    {"title": "UI/UX Design", "lecturer": "Dr. Budi Santoso", "progress": 0.8, "color": Colors.blue},
    {"title": "Kewarganegaraan", "lecturer": "Drs. Ahmad", "progress": 0.5, "color": Colors.red},
    {"title": "Sistem Operasi", "lecturer": "Agus Setiawan, S.T", "progress": 0.3, "color": Colors.purple},
    {"title": "Mobile Programming", "lecturer": "Siti Aminah, M.Kom", "progress": 0.45, "color": Colors.orange},
    {"title": "Multimedia", "lecturer": "Rina Sari, M.Bs", "progress": 0.1, "color": Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kelas Saya"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final course = classes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailScreen(courseTitle: course['title']),
                ),
              );
            },
            child: CourseCard(
              title: course['title'],
              lecturer: course['lecturer'],
              progress: course['progress'],
              baseColor: course['color'],
            ),
          );
        },
      ),
    );
  }
}
