import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/user_data.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: kPrimaryColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: const EdgeInsets.only(top: 80, bottom: 20),
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile Image (Replaced NetworkImage with Icon to avoid errors)
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 46,
                          backgroundColor: Colors.grey[200],
                          child: const Icon(Icons.person, size: 50, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Name
                      Text(
                        UserData.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: kPrimaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: kPrimaryColor,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: "About Me"),
                    Tab(text: "Kelas"),
                    Tab(text: "Edit"), // Shortened for space
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(child: _buildAboutMeTab()),
            _buildKelasTab(), // ListView supports scrolling naturally
            SingleChildScrollView(child: _buildEditProfileTab()),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutMeTab() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Informasi User",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInfoItem("Email address", UserData.email.isEmpty ? "email@example.com" : UserData.email),
          const SizedBox(height: 16),
          _buildInfoItem("Program Studi", "D4 Teknologi Rekayasa Multimedia"),
          const SizedBox(height: 16),
          _buildInfoItem("Fakultas", "FIT"),
          
          const SizedBox(height: 32),
          const Text(
            "Aktivitas Login",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
           const SizedBox(height: 16),
          _buildInfoItem("First access to site", "Monday, 7 September 2020, 9:27 AM"),
           const SizedBox(height: 16),
          _buildInfoItem("Last access to site", "Now"),

          const SizedBox(height: 32),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                 Navigator.pushAndRemoveUntil(
                   context, 
                   MaterialPageRoute(builder: (context) => const LoginScreen()),
                   (route) => false,
                 );
              },
              icon: const Icon(Icons.logout),
              label: const Text("Log Out"),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor, // CHANGED TO BLUE (Theme Color)
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildKelasTab() {
    final List<Map<String, String>> classes = [
      {"code": "D4SM-41-GAB1 [ARS]", "name": "BAHASA INGGRIS: BUSINESS AND SCIENTIFIC", "date": "Monday, 8 February 2021"},
      {"code": "D4SM-42-03 [ADY]", "name": "DESAIN ANTARMUKA", "date": "Monday, 8 February 2021"},
      {"code": "D4SM-41-GAB1 [BBO]", "name": "KEWARGANEGARAAN", "date": "Monday, 8 February 2021"},
      {"code": "D3TT-44-02 [EYR]", "name": "OLAH RAGA", "date": "Monday, 8 February 2021"},
      {"code": "D4SM-42-03 [ADY]", "name": "PEMROGRAMAN MOBILE", "date": "Monday, 8 February 2021"},
      {"code": "D4SM-42-03 [ADY]", "name": "SISTEM OPERASI", "date": "Monday, 8 February 2021"},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final item = classes[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item['name']}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Start: ${item['date']}",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEditProfileTab() {
     return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildTextField("Nama Pertama"),
            const SizedBox(height: 16),
            _buildTextField("Nama Terakhir"),
            const SizedBox(height: 16),
            _buildTextField("E-mail Address"),
            const SizedBox(height: 16),
            _buildTextField("Negara"),
            const SizedBox(height: 16),
            _buildTextField("Deskripsi", maxLines: 4),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor, // Uniform theme
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                  shadowColor: kPrimaryColor.withOpacity(0.4),
                ),
                child: const Text(
                  "Simpan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height + 20; // + padding
  @override
  double get maxExtent => _tabBar.preferredSize.height + 20;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
