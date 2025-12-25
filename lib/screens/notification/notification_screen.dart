import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../profile/profile_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        titleSpacing: 20,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Notifikasi",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
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
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: 5,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(
              Icons.assignment_outlined,
              color: Colors.black87,
            ),
            title: const Text(
              "Anda telah mengirimkan pengajuan tugas untuk Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "3 Hari 9 Jam Yang Lalu",
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          );
        },
      ),
    );
  }
}
