import 'package:flutter/material.dart';
import '../widgets/course_card.dart';
import 'course_detail_screen.dart';
import 'profile_screen.dart';


class MyClassesScreen extends StatelessWidget {
  const MyClassesScreen({super.key});

  final List<Map<String, dynamic>> classes = const [
    {
      "title": "DESAIN ANTARMUKA & PENGALAMAN PENGGUNA",
      "lecturer": "Dr. Ady Purnalink, M.Kom",
      "progress": 0.85,
      "color": Colors.orange
    },
    {
      "title": "KEWARGANEGARAAN",
      "lecturer": "Drs. Bambang Budiono, M.Pd",
      "progress": 0.55,
      "color": Colors.red
    },
    {
      "title": "SISTEM OPERASI",
      "lecturer": "Agus Setiawan, S.T., M.Cs",
      "progress": 0.80,
      "color": Colors.grey
    },
    {
      "title": "PEMROGRAMAN PERANGKAT BERGERAK",
      "lecturer": "Ahmad Mujahidin, S.Kom., M.T",
      "progress": 0.80,
      "color": Colors.cyan
    },
    {
      "title": "BAHASA INGGRIS: BUSINESS AND SCIENTIFIC",
      "lecturer": "Ari Santoso, S.S., M.Hum",
      "progress": 0.80,
      "color": Colors.blueGrey
    },
    {
      "title": "PEMROGRAMAN MULTIMEDIA INTERAKTIF",
      "lecturer": "Taufik Prayitno, M.T",
      "progress": 0.80,
      "color": Colors.blue
    },
    {
      "title": "OLAH RAGA",
      "lecturer": "Eko Yulianto, S.Pd., M.Or",
      "progress": 0.80,
      "color": Colors.indigo
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 20,
        title: const Text(
          "Kelas Saya",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[200],
            height: 1.0,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final course = classes[index];
          return CourseCard(
            title: course['title'],
            lecturer: course['lecturer'],
            progress: course['progress'],
            baseColor: course['color'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CourseDetailScreen(courseTitle: course['title']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
