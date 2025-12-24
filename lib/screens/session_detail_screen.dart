import 'package:flutter/material.dart';
import '../theme.dart';
import 'video_learning_screen.dart';
import 'material_view_screen.dart';

class SessionDetailScreen extends StatefulWidget {
  final String sessionTitle;
  final String description;
  final List<Map<String, dynamic>>? materials;

  const SessionDetailScreen({
    super.key,
    required this.sessionTitle,
    this.description = "Pada pertemuan ini kita akan membahas materi terkait topik yang telah ditentukan untuk memperdalam pemahaman mahasiswa.",
    this.materials,
  });

  @override
  State<SessionDetailScreen> createState() => _SessionDetailScreenState();
}

class _SessionDetailScreenState extends State<SessionDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      appBar: AppBar(
        title: const Text("Detail Pertemuan"), // Generic title or dynamic
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.sessionTitle,
                      style: kHeaderStyle.copyWith(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Deskripsi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: kBodyStyle.copyWith(color: Colors.grey[800], height: 1.5),
                    ),
                    const SizedBox(height: 20),
                  ],
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
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: "Lampiran Materi"),
                    Tab(text: "Tugas dan Kuis"),
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
            _buildMateriList(),
            _buildTugasList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMateriList() {
    final List<Map<String, dynamic>> defaultItems = [
      {"title": "Zoom Meeting Syncronous", "icon": Icons.link, "type": "link"},
      {"title": widget.sessionTitle, "icon": Icons.description, "type": "pdf"},
      {"title": "Materi Tambahan 1", "icon": Icons.description, "type": "pdf"},
      {"title": "Video Pembelajaran", "icon": Icons.video_library, "type": "video"},
    ];

    final List<Map<String, dynamic>> items = widget.materials ?? defaultItems;

    return ListView.builder(
      primary: false, // Penting untuk NestedScrollView
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: Icon(item['icon'], color: Colors.black87),
            title: Text(
              item['title'],
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            trailing: const Icon(Icons.check_circle, color: kAccentColor),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            onTap: () {
              if (item['type'] == 'video') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoLearningScreen(
                      videoTitle: "Video - User Interface Design For Beginner",
                    ),
                  ),
                );
              } else if (item['type'] == 'pdf' && item['title'] == 'Pengantar User Interface Design') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MaterialViewScreen(
                      title: item['title'],
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildTugasList() {
    // Placeholder similar to materi
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.assignment_outlined, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text("Belum ada tugas atau kuis"),
            ],
          ),
        ),
      ),
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
      color: Colors.white, // Background of the Sticky Header
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
