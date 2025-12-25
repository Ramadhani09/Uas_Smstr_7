import 'package:flutter/material.dart';
import '../../theme/theme.dart';

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
    const Color headerColor = kPrimaryColor;

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
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSummaryRow("Di Mulai Pada", "Kamis 25 Februari 2021 10:25"),
                  const Divider(height: 16, color: Colors.transparent),
                  _buildSummaryRow("Status", "Selesai"),
                  const Divider(height: 16, color: Colors.transparent),
                  _buildSummaryRow("Selesai Pada", "Kamis 25 Februari 2021 10:40"),
                  const Divider(height: 16, color: Colors.transparent),
                  _buildSummaryRow("Waktu Penyelesaian", "13 Menit 22 Detik"),
                  const Divider(height: 16, color: Colors.transparent),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 90,
                            child: Text(
                              "Pertanyaan ${index + 1}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600, 
                                fontSize: 13,
                                color: Colors.black87
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0E0E0), // Grey from image
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text(
                                questions[index]['question'],
                                style: const TextStyle(fontSize: 12, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Jawaban Tersimpan", 
                                  style: TextStyle(fontSize: 12, color: Colors.black)
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  answerText,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold, 
                                    fontSize: 13,
                                    color: Colors.black87
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context, index);
                              },
                              child: const Text(
                                "Lihat Soal", 
                                style: TextStyle(
                                  color: Colors.blue, 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Divider(height: 1, thickness: 0.5),
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
                  width: 200,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      _showSuccessDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor, 
                      foregroundColor: Colors.white,
                      elevation: 0,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label, 
            style: const TextStyle(
              fontSize: 12, 
              fontWeight: FontWeight.bold,
              color: Colors.black87
            )
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value, 
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54
            )
          ),
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
