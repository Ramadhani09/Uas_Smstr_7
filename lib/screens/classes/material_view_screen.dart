import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class MaterialViewScreen extends StatelessWidget {
  final String title;

  const MaterialViewScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = kPrimaryColor;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              border: Border.all(color: Colors.black54),
            ),
            child: const Text(
              "Halaman\n1/26",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, height: 1.1),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(4),
        children: [
          _buildSlide1(),
          _buildSlide2(),
          _buildSlide3(),
          _buildSlide4(),
        ],
      ),
    );
  }

  Widget _buildSlide1() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      height: 250,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage("https://images.unsplash.com/photo-1497215728101-856f4ea42174?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80"),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(Icons.school, size: 50, color: Colors.grey),
                const Text(
                  "Universitas\nTelkom",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )
              ],
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 80),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              width: double.infinity,
              color: const Color(0xFF404040).withOpacity(0.9),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Pengantar Desain\nAntarmuka Pengguna",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 40,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "VEI214\nUI/UX Design",
                    style: TextStyle(color: Colors.red, fontSize: 10),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSlide2() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(30),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            "Perkenalan",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.grey[200],
                backgroundImage: const NetworkImage("https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80"),
                onBackgroundImageError: (exception, stackTrace) {
                  // Handled by backgroundColor and potentially a child icon
                },
                child: const Icon(Icons.person, size: 50, color: Colors.grey),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBulletPoint("Ady Purna Kurniawan -> ADY"),
                    _buildBulletPoint("E-mail:\nadypurnakurniawan@telkomuniversity.ac.id"),
                    _buildBulletPoint("Bidang Keahlian:"),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("- Information System", style: TextStyle(fontSize: 13)),
                          const Text("- Web Programming and Design", style: TextStyle(fontSize: 13)),
                          const Text("- Game Development", style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                    _buildBulletPoint("No.HP: 085727930642 -> SMS/Telp/Whatsapp"),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSlide3() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(30),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            "User Interface",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 20),
          _buildBulletPoint(
            "Antarmuka/ user interface (UI) merupakan bagian dari komputer dan perangkat lunaknya yang dapat dilihat, didengar, disentuh, dan diajak bicara, baik secara langsung maupun dengan proses pemahaman tertentu.",
          ),
          _buildBulletPoint(
            "UI yang baik adalah UI yang tidak disadari, dan UI yang memungkinkan pengguna fokus pada informasi dan task tanpa perlu mengetahui mekanisme untuk menampilkan informasi dan melakukan task tersebut.",
          ),
          _buildBulletPoint("Komponen utamanya:\n- Input\n- Output"),
        ],
      ),
    );
  }

  Widget _buildSlide4() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(30),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Pentingnya Desain UI yang Baik",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(height: 30),
          _buildBulletPoint(
            "Banyak sistem dengan fungsionalitas yang baik tapi tidak efisien, membingungkan, dan tidak berguna karena desain UI yang buruk",
          ),
          _buildBulletPoint(
            "Antarmuka yang baik merupakan jendela untuk melihat kemampuan sistem serta jembatan bagi kemampuan perangkat lunak",
          ),
          _buildBulletPoint(
            "Desain yang buruk akan membingungkan, tidak efisien, bahkan menyebabkan frustasi",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.network(
                "https://images.unsplash.com/photo-1590402494587-44b71d7772f6?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80",
                height: 100,
                width: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 100,
                  width: 120,
                  color: Colors.grey[100],
                  child: const Icon(Icons.sentiment_very_dissatisfied, color: Colors.grey),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.4, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
