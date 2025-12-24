import 'package:flutter/material.dart';
import 'announcement_detail_screen.dart';

class AnnouncementListScreen extends StatelessWidget {
  const AnnouncementListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> announcements = [
      {
        "title": "Maintenance Pra UAS Semester Genap 2020/2021",
        "author": "By Admin Celoe",
        "date": "Rabu 2 Juni 2021 13:41",
      },
      {
        "title": "Pengumuman Maintenance",
        "author": "By Admin Celoe",
        "date": "Senin, 18 Januari 2021 21:52",
      },
      {
        "title": "Maintenance Pra UAS Semester Ganjil 2020/2021",
        "author": "By Admin Celoe",
        "date": "Minggu, 10 Januari 2021 13:00",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Pengumuman",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      body: ListView.separated(
        itemCount: announcements.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final announcement = announcements[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            leading: const Icon(
              Icons.campaign, // Megaphone icon
              color: Colors.black87,
              size: 28,
            ),
            title: Text(
              announcement['title']!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                "${announcement['author']} - ${announcement['date']}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ),
            onTap: () {
              // For demo purposes, they all go to the same detail page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AnnouncementDetailScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
