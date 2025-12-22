import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/course_card.dart';
import '../data/user_data.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hallo, ${UserData.name}",
                        style: kHeaderStyle.copyWith(fontSize: 20),
                      ),
                      const Text(
                        "Selamat datang kembali!",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfileScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          const Text(
                            "Profil",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.person, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Task Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryColor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Tugas 01",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Desain Antarmuka Pengguna",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Waktu Pengumpulan: Besok, 23:59",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Announcements
              const Text(
                "Pengumuman Terakhir",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage('https://via.placeholder.com/600x200'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Banner Pengumuman",
                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Course Progress
              const Text(
                "Progres Kelas",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              // Sample List
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  CourseCard(
                    title: "UI/UX Design",
                    lecturer: "Dr. Budi Santoso",
                    progress: 0.75,
                    baseColor: Colors.blue,
                  ),
                  CourseCard(
                    title: "Pemrograman Mobile",
                    lecturer: "Siti Aminah, M.Kom",
                    progress: 0.45,
                    baseColor: Colors.orange,
                  ),
                  CourseCard(
                    title: "Sistem Operasi",
                    lecturer: "Agus Setiawan, S.T",
                    progress: 0.20,
                    baseColor: Colors.purple,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
