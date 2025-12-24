import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/course_card.dart';
import '../data/user_data.dart';
import 'profile_screen.dart';
import 'course_detail_screen.dart';
import 'announcement_detail_screen.dart';
import 'announcement_list_screen.dart';
import 'package:flutter/foundation.dart'; // Add this for kIsWeb
import 'dart:io';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Blue like image
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Halo,",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          UserData.name.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00007A), // Darker blue
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                "MAHASISWA",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Task Section Title
                    const Text(
                      "Tugas Yang Akan Datang",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "DESAIN ANTARMUKA & PENGALAMAN PENGGUNA",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Tugas 01 - UID Android Mobile Game",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Waktu Pengumpulan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Jumat 26 Februari, 23:59 WIB",
                            style:
                                TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Announcements
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pengumuman Terakhir",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AnnouncementListScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Lihat Semua",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AnnouncementDetailScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/maintenance_banner.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.blue.shade50,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.announcement,
                                            color: Colors.blue.shade300, size: 40),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Maintenance LMS",
                                          style: TextStyle(
                                              color: Colors.blue.shade700,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Course Progress
                    const Text(
                      "Progres Kelas",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),

              // Sample List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    CourseCard(
                      title: "DESAIN ANTARMUKA & PENGALAMAN PENGGUNA",
                      lecturer: "Dr. Ady Purnalink, M.Kom",
                      progress: 0.85,
                      baseColor: Colors.orange,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseDetailScreen(
                                courseTitle:
                                    "DESAIN ANTARMUKA & PENGALAMAN PENGGUNA"),
                          ),
                        );
                      },
                    ),
                    CourseCard(
                      title: "KEWARGANEGARAAN",
                      lecturer: "Drs. Bambang Budiono, M.Pd",
                      progress: 0.55,
                      baseColor: Colors.red,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseDetailScreen(
                                courseTitle: "KEWARGANEGARAAN"),
                          ),
                        );
                      },
                    ),
                    CourseCard(
                      title: "SISTEM OPERASI",
                      lecturer: "Agus Setiawan, S.T., M.Cs",
                      progress: 0.80,
                      baseColor: Colors.grey,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseDetailScreen(
                                courseTitle: "SISTEM OPERASI"),
                          ),
                        );
                      },
                    ),
                    CourseCard(
                      title: "PEMROGRAMAN PERANGKAT BERGERAK",
                      lecturer: "Ahmad Mujahidin, S.Kom., M.T",
                      progress: 0.80,
                      baseColor: Colors.cyan,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseDetailScreen(
                                courseTitle: "PEMROGRAMAN PERANGKAT BERGERAK"),
                          ),
                        );
                      },
                    ),
                    CourseCard(
                      title: "BAHASA INGGRIS: BUSINESS AND SCIENTIFIC",
                      lecturer: "Ari Santoso, S.S., M.Hum",
                      progress: 0.80,
                      baseColor: Colors.blueGrey,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseDetailScreen(
                                courseTitle: "BAHASA INGGRIS"),
                          ),
                        );
                      },
                    ),
                    CourseCard(
                      title: "PEMROGRAMAN MULTIMEDIA INTERAKTIF",
                      lecturer: "Taufik Prayitno, M.T",
                      progress: 0.80,
                      baseColor: Colors.blue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseDetailScreen(
                                courseTitle: "PEMROGRAMAN MULTIMEDIA"),
                          ),
                        );
                      },
                    ),
                    CourseCard(
                      title: "OLAH RAGA",
                      lecturer: "Eko Yulianto, S.Pd., M.Or",
                      progress: 0.80,
                      baseColor: Colors.indigo,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseDetailScreen(
                                courseTitle: "OLAH RAGA"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
