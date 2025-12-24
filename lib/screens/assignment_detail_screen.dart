import 'package:flutter/material.dart';
import '../theme.dart';

class AssignmentDetailScreen extends StatelessWidget {
  final String assignmentTitle;

  const AssignmentDetailScreen({super.key, required this.assignmentTitle});

  @override
  Widget build(BuildContext context) {
    // Use theme colors
    const Color primaryBlue = kPrimaryColor;
    final Color lightBlue = kPrimaryColor.withOpacity(0.8);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          assignmentTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInstructionItem(
                      "1. Buatlah desain tampilan (antarmuka) pada aplikasi mobile game FPS (First Person Shooter) yang akan menjadi tugas pada mata kuliah Pemrograman Aplikasi Permainan."),
                  _buildInstructionItem(
                      "2. Desain yang dibuat harus melingkupi seluruh tampilan pada aplikasi/game, dari pertama kali aplikasi dibuka sampai ditutup kembali, serta desain untuk tampilan-tampilan fungsi yang mendukung permainan seperti pop-up, alert, chat, dan lain-lain."),
                  _buildInstructionItem(
                      "3. Desain bisa dibuat menggunakan aplikasi khusus desain atau secara manual dengan tetap menjunjung kerapihan dan kejelasan setiap elemen dalam desain."),
                  _buildInstructionItem(
                      "4. Berikan identitas aplikasi game yang dibuat, seperti Nama Game, Genre, dan Platform. Serta berikan penjelasan pada setiap elemen pada desain, seperti gambar, teks, tombol, icon, dan lain-lain."),
                  _buildInstructionItem(
                      "5. File dikumpulkan dalam format .PDF dengan size maksimal 5MB."),
                  _buildInstructionItem(
                      "6. Tugas dikumpulkan paling lambat hari Jum'at, 26 Februari 2021 jam 23:59 WIB (akan tertutup otomatis) dan akan dipresentasikan pada pertemuan selanjutnya via Zoom Meeting."),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              color: lightBlue,
              child: const Text(
                "Status Tugas",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            _buildStatusRow("Status", "Sudah Mengirim untuk di nilai", isEven: true),
            _buildStatusRow("Status Nilai", "Belum Di nilai", isEven: false),
            _buildStatusRow("Batas tanggal", "Jumat, 26 Februari 2021, 23:59 WIB", isEven: true),
            _buildStatusRow("Sisa Waktu", "Tugas sudah di kirim 4 Hari 6 Jam Sebelum nya", isEven: false),
            _buildStatusRow("File Tugas", "Dandy Candra Pratama_7708170114.pdf",
                isEven: true, isFile: true),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showUploadBottomSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5F5F5),
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Tambahkan Tugas",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          height: 1.6,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, String value,
      {required bool isEven, bool isFile = false}) {
    return Container(
      color: isEven ? const Color(0xFFF9F9F9) : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                if (isFile)
                  const Icon(Icons.description,
                      size: 22, color: Colors.grey),
                if (isFile) const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      color: isFile ? Colors.black87 : Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showUploadBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const UploadAssignmentSheet(),
    );
  }
}

class UploadAssignmentSheet extends StatelessWidget {
  const UploadAssignmentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    const Color maroonColor = Color(0xFFB74D4D);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Container(
                  width: 80,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const Spacer(),
                const Text(
                  "Upload File",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Maksimum File 5MB , Maksimum Jumlah File 20",
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CustomPaint(
                      painter: DashedRectPainter(color: Colors.black38),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_upload,
                                size: 120, color: Colors.blue[400]),
                            const SizedBox(height: 15),
                            const Text(
                              "File yang akan di upload akan tampil di sini",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5F5F5),
                      foregroundColor: Colors.black87,
                      minimumSize: const Size(220, 55),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Pilih File",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5F5F5),
                      foregroundColor: Colors.black87,
                      minimumSize: const Size(220, 55),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Simpan",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashedRectPainter extends CustomPainter {
  final Color color;
  DashedRectPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 8.0;
    const dashSpace = 8.0;

    // Drawing dashed border
    void drawDashedLine(Offset start, Offset end) {
      double distance = (end - start).distance;
      for (double i = 0; i < distance; i += dashWidth + dashSpace) {
        canvas.drawLine(
          start + (end - start) * (i / distance),
          start + (end - start) * ((i + dashWidth) / distance),
          paint,
        );
      }
    }

    drawDashedLine(const Offset(10, 10), Offset(size.width - 10, 10)); // Top
    drawDashedLine(Offset(size.width - 10, 10), Offset(size.width - 10, size.height - 10)); // Right
    drawDashedLine(Offset(size.width - 10, size.height - 10), Offset(10, size.height - 10)); // Bottom
    drawDashedLine(Offset(10, size.height - 10), const Offset(10, 10)); // Left
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
