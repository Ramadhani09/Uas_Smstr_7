import 'package:flutter/material.dart';
import '../theme.dart';

class ReviewQuizScreen extends StatelessWidget {
  final List<int?> answers;
  final List<Map<String, dynamic>> questions;
  final String quizTitle;

  const ReviewQuizScreen({
    super.key,
    required this.answers,
    required this.questions,
    required this.quizTitle,
  });

  @override
  Widget build(BuildContext context) {
    const Color headerColor = kPrimaryColor; // Updated to Blue theme

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Review Jawaban"),
        backgroundColor: headerColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Summary Card
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50], 
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _buildSummaryRow("Di Mulai Pada", "Kamis 25 Februari 2021 10:25"),
                  const SizedBox(height: 8),
                  _buildSummaryRow("Status", "Selesai"),
                  const SizedBox(height: 8),
                  _buildSummaryRow("Selesai Pada", "Kamis 25 Februari 2021 10:40"),
                  const SizedBox(height: 8),
                  _buildSummaryRow("Waktu Penyelesaian", "13 Menit 22 Detik"),
                  const SizedBox(height: 8),
                  _buildSummaryRow("Nilai", "0 / 100"),
                ],
              ),
            ),

            // Questions List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final int? selectedOption = answers[index];
                final String answerText = selectedOption != null 
                    ? "${String.fromCharCode(65 + selectedOption)}. ${questions[index]['options'][selectedOption]}"
                    : "Belum dijawab";

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pertanyaan ${index + 1}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                questions[index]['question'],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Jawaban Tersimpan", style: TextStyle(fontSize: 13)),
                              const SizedBox(height: 4),
                              Text(
                                answerText,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context, index); // Go back to specific question
                              },
                              child: const Text("Lihat Soal", style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
            
            // Submit Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      _showSuccessDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF39F11F), // Original Green color
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Kirim Jawaban", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          flex: 3,
          child: Text(value, style: const TextStyle(fontSize: 12)),
        ),
      ],
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Diterima"),
        content: const Text("Jawaban Anda telah berhasil dikirim."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // dialog
              Navigator.of(context).pop(); // review screen
              Navigator.of(context).pop(); // quiz screen
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
