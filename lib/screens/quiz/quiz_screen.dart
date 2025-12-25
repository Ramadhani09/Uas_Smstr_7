import 'package:flutter/material.dart';
import 'dart:async';
import '../../theme/theme.dart';
import 'quiz_review_screen.dart';

class QuizScreen extends StatefulWidget {
  final String quizTitle;

  const QuizScreen({super.key, required this.quizTitle});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final List<int?> _answers = List.generate(15, (index) => null);
  
  // Timer state
  late Timer _timer;
  int _secondsRemaining = 900; // 15 minutes

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
        _finishQuiz();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')} : ${remainingSeconds.toString().padLeft(2, '0')}";
  }

  void _finishQuiz() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Kuis Selesai"),
        content: const Text("Apakah Anda yakin ingin mengakhiri kuis ini dan lanjut ke review?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _goToReview();
            }, 
            child: const Text("Ya, Lanjut")
          ),
        ],
      ),
    );
  }

  Future<void> _goToReview() async {
    final int? targetIndex = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewQuizScreen(
          answers: _answers,
          questions: _questions,
          quizTitle: widget.quizTitle,
        ),
      ),
    );

    if (targetIndex != null) {
      if (mounted) {
        setState(() {
          _currentQuestionIndex = targetIndex;
        });
      }
    }
  }

  final List<Map<String, dynamic>> _questions = [
    {
      "question": "Radio button dapat digunakan untuk menentukan ?",
      "options": ["Jenis Kelamin", "Alamat", "Hobby", "Riwayat Pendidikan", "Umur"]
    },
    {
      "question": "Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?",
      "options": ["Intergrasi", "Standarisasi", "Konsistensi", "Koefensi", "Koreksi"]
    },
    {
      "question": "Salah satu prinsip desain antarmuka yang memberikan petunjuk kepada pengguna tentang apa yang telah dilakukan sistem disebut ?",
      "options": ["User Control", "Visibility of System Status", "Efficiency", "Consistency", "Error Prevention"]
    },
    for (int i = 4; i <= 15; i++)
      {
        "question": "Pertanyaan nomor $i: Contoh pertanyaan pilihan ganda terkait UI/UX Design.",
        "options": ["Pilihan A", "Pilihan B", "Pilihan C", "Pilihan D", "Pilihan E"]
      }
  ];

  @override
  Widget build(BuildContext context) {
    const Color quizHeaderColor = kPrimaryColor;
    const Color selectedOptionColor = kPrimaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with Timer
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
            color: quizHeaderColor,
            child: Column(
              children: [
                Center(
                  child: Text(
                    widget.quizTitle,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.timer, color: Colors.white, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      _formatTime(_secondsRemaining),
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Question Navigator
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: List.generate(15, (index) {
                bool isAnswered = _answers[index] != null;
                bool isCurrent = _currentQuestionIndex == index;
                
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentQuestionIndex = index;
                      });
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isAnswered ? Colors.greenAccent[400] : (isCurrent ? Colors.white : Colors.white),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isAnswered ? Colors.greenAccent[700]! : Colors.grey[400]!,
                          width: isCurrent ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Question Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Soal Nomor ${_currentQuestionIndex + 1} / 15",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    _questions[_currentQuestionIndex]["question"],
                    style: const TextStyle(fontSize: 15, height: 1.6),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Options
                  ...List.generate(5, (index) {
                    bool isSelected = _answers[_currentQuestionIndex] == index;
                    String optionPrefix = String.fromCharCode(65 + index);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _answers[_currentQuestionIndex] = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        decoration: BoxDecoration(
                          color: isSelected ? selectedOptionColor : Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: selectedOptionColor.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(
                              "$optionPrefix.  ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _questions[_currentQuestionIndex]["options"][index],
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Bottom Navigation Buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Stack(
              children: [
                if (_currentQuestionIndex > 0)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildNavButton("Soal Sebelum nya.", () {
                      setState(() {
                        _currentQuestionIndex--;
                      });
                    }),
                  ),
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: _currentQuestionIndex == 0 
                    ? _buildNavButton("Kembali Ke Halam Review", () => Navigator.pop(context))
                    : const SizedBox.shrink(),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: _currentQuestionIndex < 14
                    ? _buildNavButton("Soal Selanjut nya.", () {
                        setState(() {
                          _currentQuestionIndex++;
                        });
                      })
                    : _buildNavButton("Soal Selanjut nya.", _goToReview),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String text, VoidCallback onTap, {bool isPrimary = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isPrimary ? Colors.greenAccent[400] : Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isPrimary ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
