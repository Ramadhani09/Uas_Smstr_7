import 'package:flutter/material.dart';
import '../theme.dart';
import 'quiz_screen.dart';

class QuizDetailScreen extends StatelessWidget {
  final String quizTitle;

  const QuizDetailScreen({super.key, required this.quizTitle});

  @override
  Widget build(BuildContext context) {
    const Color quizHeaderColor = kPrimaryColor; // Updated to Blue theme

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(quizTitle),
        backgroundColor: quizHeaderColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Silahkan kerjakan kuis ini dalam waktu 15 menit sebagai nilai pertama komponen kuis.",
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                  const Text(
                    "Jangan lupa klik tombol Submit Answer setelah menjawab seluruh pertanyaan.",
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Kerjakan sebelum hari Jum'at, 26 Februari 2021 jam 23:59 WIB.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            // Info Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _buildInfoRow("Kuis Akan di tutup pada Jumat, 26 Februari 2021, 11:59 PM"),
                  const SizedBox(height: 12),
                  _buildInfoRow("Batas Waktu: 15 menit"),
                  const SizedBox(height: 12),
                  _buildInfoRow("Metode Penilaian: Nilai Tertinggi"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Attempts Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Percobaan Yang Sudah Di Lakukan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            // Attempts Header
            Container(
              color: kPrimaryColor.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: const [
                  Expanded(flex: 3, child: Text("Status", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text("Nilai / 100.00", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))),
                  Expanded(flex: 2, child: Text("Tinjau Kembali", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))),
                ],
              ),
            ),

            // Attempt Item
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Selesai", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Dikirim Pada Kamis, 25 Februari 2021, 10:40", style: TextStyle(color: Colors.grey[600], fontSize: 11)),
                      ],
                    ),
                  ),
                  const Expanded(flex: 2, child: Text("85,0")),
                  Expanded(
                    flex: 2,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          // Review logic
                        },
                        child: const Text("Lihat", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Center(
              child: Text(
                "Nilai Akhir Anda Unutuk Kuis Ini Adalah 85.0 / 100.00",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),

            const SizedBox(height: 40),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuizScreen(quizTitle: quizTitle)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        foregroundColor: Colors.black87,
                        elevation: 0,
                      ),
                      child: const Text("Ambil Kuis"),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        foregroundColor: Colors.black87,
                        elevation: 0,
                      ),
                      child: const Text("Kembali Ke Kelas"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 13, color: Colors.black87),
    );
  }
}
