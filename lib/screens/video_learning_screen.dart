import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';

class VideoLearningScreen extends StatefulWidget {
  final String videoTitle;

  const VideoLearningScreen({
    super.key,
    required this.videoTitle,
  });

  @override
  State<VideoLearningScreen> createState() => _VideoLearningScreenState();
}

class _VideoLearningScreenState extends State<VideoLearningScreen> {
  late YoutubePlayerController _controller;
  late String currentTitle;
  late String currentVideoId;
  bool _showFallback = false;

  final List<Map<String, String>> videos = [
    {
      "title": "Tutorial Figma Pemula 2025 | Belajar Desain UI/UX",
      "url": "https://www.youtube.com/watch?v=WW2uRdzLumk",
    },
    {
      "title": "Introduction to Computer Science and Programming",
      "url": "https://www.youtube.com/watch?v=tpIctyqH29Q",
    },
    {
      "title": "The Psychology of Color in Design | TED-Ed",
      "url": "https://www.youtube.com/watch?v=x0mJXPzAt-w",
    },
    {
      "title": "Full Flutter Course for Beginners | freeCodeCamp",
      "url": "https://www.youtube.com/watch?v=lHh9He7FzK4",
    },
    {
      "title": "NASA | James Webb Space Telescope First Images",
      "url": "https://www.youtube.com/watch?v=4P8fKd0qzKw",
    },
  ];

  @override
  void initState() {
    super.initState();
    currentTitle = videos[0]['title']!;
    currentVideoId = _extractId(videos[0]['url']!);
    _initController(currentVideoId);
  }

  void _initController(String videoId) {
    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        mute: false,
        showControls: true,
        enableJavaScript: true,
        // Parameter origin penting untuk menghindari blokir IFrame di Web
      ),
    );

    // Listen for error states
    _controller.listen((state) {
      // Optional: Add state listening logic here if needed for newer versions
    });

    setState(() {
      _showFallback = false;
    });
  }

  String _extractId(String url) {
    RegExp regExp = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    }
    return url;
  }

  Future<void> _launchYoutube(String videoId) async {
    final Uri url = Uri.parse('https://www.youtube.com/watch?v=$videoId');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka YouTube')),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _changeVideo(String title, String url) {
    final videoId = _extractId(url);
    if (currentVideoId == videoId) return;

    setState(() {
      currentTitle = title;
      currentVideoId = videoId;
      _showFallback = false;
    });
    _initController(videoId);
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = kPrimaryColor;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Video Pembelajaran",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 800;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video Player Block with Fallback
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 1000,
                            maxHeight: isDesktop ? 550 : double.infinity,
                          ),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                YoutubePlayer(
                                  key: ValueKey(currentVideoId),
                                  controller: _controller,
                                ),
                                // Overlay Fallback Button (Always visible as helpful link if video stuck)
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: ElevatedButton.icon(
                                      onPressed: () => _launchYoutube(currentVideoId),
                                      icon: const Icon(Icons.open_in_new, size: 16),
                                      label: const Text("Buka di YouTube", style: TextStyle(fontSize: 12)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Video Info & List
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 40 : 20, vertical: 24),
                      child: isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: _buildMainInfo(currentTitle),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  flex: 1,
                                  child: _buildPlaylist(primaryBlue),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMainInfo(currentTitle),
                                const Divider(height: 40),
                                _buildPlaylist(primaryBlue),
                              ],
                            ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainInfo(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: kPrimaryColor.withOpacity(0.1),
              child: const Icon(Icons.school, color: kPrimaryColor),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "CeLOE Telkom University",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "Materi Kuliah • 2025",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          "Video ini membahas tentang dasar-dasar perancangan antarmuka pengguna (User Interface) yang efektif dan efisien, mencakup prinsip desain, teori warna, dan penggunaan tool industri.",
          style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
        ),
      ],
    );
  }

  Widget _buildPlaylist(Color primaryBlue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Daftar Materi Video",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            final videoId = _extractId(video['url']!);
            bool isPlaying = currentVideoId == videoId;

            return InkWell(
              onTap: () => _changeVideo(video['title']!, video['url']!),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isPlaying ? primaryBlue.withOpacity(0.08) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isPlaying ? primaryBlue.withOpacity(0.3) : Colors.grey.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            "https://img.youtube.com/vi/$videoId/hqdefault.jpg",
                            width: 100,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 100,
                              height: 60,
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image, size: 20),
                            ),
                          ),
                        ),
                        if (isPlaying)
                          const Icon(Icons.play_circle_filled, color: Colors.white, size: 24),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        video['title']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isPlaying ? FontWeight.bold : FontWeight.w500,
                          color: isPlaying ? primaryBlue : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
