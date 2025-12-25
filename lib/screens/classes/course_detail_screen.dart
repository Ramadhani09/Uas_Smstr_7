import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import 'session_detail_screen.dart';
import '../quiz/quiz_detail_screen.dart';
import '../assignment/assignment_detail_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseTitle;

  const CourseDetailScreen({super.key, required this.courseTitle});

  List<Map<String, String>> getSessions() {
    switch (courseTitle.toUpperCase()) {
      case "DESAIN ANTARMUKA & PENGALAMAN PENGGUNA":
        return [
          {
            "title": "Pengantar User Interface Design",
            "desc":
                "Mengenal dasar-dasar perancangan antarmuka pengguna yang efektif dan efisien."
          },
          {
            "title": "Prinsip-Prinsip Desain Antarmuka",
            "desc":
                "Mempelajari 8 Golden Rules dan prinsip desain lainnya untuk usability."
          },
          {
            "title": "User Experience (UX) Research",
            "desc":
                "Metode riset pengguna untuk memahami kebutuhan dan perilaku target audiens."
          },
          {
            "title": "Wireframing & Prototyping",
            "desc":
                "Proses pembuatan kerangka kerja dan prototipe interaktif menggunakan tools desain."
          },
          {
            "title": "Usability Testing",
            "desc":
                "Melakukan pengujian produk langsung ke pengguna untuk evaluasi desain."
          },
        ];
      case "KEWARGANEGARAAN":
        return [
          {
            "title": "Pendidikan Kewarganegaraan",
            "desc": "Hakekat dan urgensi pendidikan kewarganegaraan di PT."
          },
          {
            "title": "Identitas Nasional",
            "desc": "Unsur-unsur pembentuk identitas nasional Indonesia."
          },
          {
            "title": "Integrasi Nasional",
            "desc": "Pentingnya persatuan di tengah keberagaman bangsa."
          },
          {
            "title": "Konstitusi Indonesia",
            "desc": "Sejarah amandemen dan fungsi UUD 1945."
          },
          {
            "title": "Hak dan Kewajiban Negara",
            "desc": "Keseimbangan antara hak dan kewajiban warga negara."
          },
        ];
      case "SISTEM OPERASI":
        return [
          {
            "title": "Pengenalan Sistem Operasi",
            "desc": "Fungsi utama dan evolusi sistem operasi komputer."
          },
          {
            "title": "Struktur Sistem Komputer",
            "desc": "Interaksi hardware dengan software melalui OS."
          },
          {
            "title": "Manajemen Proses",
            "desc": "Konsep process, thread, dan life cycle-nya."
          },
          {
            "title": "Penjadwalan CPU",
            "desc": "Algoritma FCFS, SJF, RR, dan Priority scheduling."
          },
          {
            "title": "Sinkronisasi Proses",
            "desc": "Menangani Race Condition menggunakan Semaphoren."
          },
        ];
      case "PEMROGRAMAN PERANGKAT BERGERAK":
        return [
          {
            "title": "Pengenalan Flutter & Dart",
            "desc": "Setup environment dan dasar bahasa pemrograman Dart."
          },
          {
            "title": "Widget & Layout",
            "desc": "Membangun UI menggunakan Stateless dan Stateful widget."
          },
          {
            "title": "Navigasi & Routing",
            "desc": "Berpindah antar halaman dan mengirim data."
          },
          {
            "title": "State Management",
            "desc": "Mengelola data aplikasi menggunakan Provider/Bloc."
          },
          {
            "title": "Integrasi REST API",
            "desc": "Mengambil data dari internet menggunakan package http."
          },
        ];
      default:
        return List.generate(
            5,
            (i) => {
                  "title": "Materi Pertemuan ${i + 1}",
                  "desc": "Pembahasan topik pertemuan ke-${i + 1}."
                });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessions = getSessions();

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
              controller: ScrollController(), // Menggunakan controller sendiri
              padding: const EdgeInsets.all(16),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SessionDetailScreen(
                            sessionTitle: session['title']!,
                            description: session['desc']!,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.folder, color: kPrimaryColor),
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
                                  session['title']!,
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

            // Tugas Dan Kuis Tab (Refactored)
            ListView(
              controller: ScrollController(), // Menggunakan controller sendiri
              padding: const EdgeInsets.all(20),
              children: [
                _buildTaskCard(
                  context,
                  tag: "QUIZ",
                  title: "Quiz Review 01",
                  date: "26 Februari 2021 23:59 WIB",
                  icon: Icons.chat_bubble_outline,
                  isQuiz: true,
                ),
                _buildTaskCard(
                  context,
                  tag: "Tugas",
                  title: "Tugas 01 - UID Android Mobile Game",
                  date: "26 Februari 2021 23:59 WIB",
                  icon: Icons.assignment,
                  isQuiz: false,
                ),
                _buildTaskCard(
                  context,
                  tag: "Pertemuan 3",
                  title: "Kuis - Assessment 2",
                  date: "26 Februari 2021 23:59 WIB",
                  icon: Icons.chat_bubble_outline,
                  isQuiz: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(
    BuildContext context, {
    required String tag,
    required String title,
    required String date,
    required IconData icon,
    required bool isQuiz,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (isQuiz) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizDetailScreen(quizTitle: title),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssignmentDetailScreen(assignmentTitle: title),
              ),
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Tag and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue[400], // Light blue for tag
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(Icons.check_circle, color: kAccentColor, size: 24),
                ],
              ),
              const SizedBox(height: 16),

              // Content: Icon and Title
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  isQuiz
                      ? Stack(
                          children: [
                            const Icon(Icons.chat_bubble_outline, size: 40, color: Colors.black),
                            Positioned(
                              top: 8,
                              left: 4,
                              right: 4,
                              child: const Text(
                                "Quiz",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Icon(Icons.assignment_outlined, size: 40, color: Colors.black),
                  
                  const SizedBox(width: 16),
                  
                  // Title
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Footer: Date
              Text(
                "Tenggat Waktu :  $date",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
