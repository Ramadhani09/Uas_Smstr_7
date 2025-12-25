import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../data/user_data.dart';
import '../auth/login_screen.dart';
import '../classes/course_detail_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Controllers for edit profile form
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Initialize controllers with current user data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeControllers();
    });
  }

  void _initializeControllers() {
    // Extract first name and last name from UserData.name
    String fullName = UserData.name;
    String firstName = fullName;
    String lastName = "";

    if (fullName.contains(" ")) {
      List<String> nameParts = fullName.split(" ");
      firstName = nameParts[0];
      lastName = nameParts.skip(1).join(" ");
    }

    _firstNameController.text = firstName;
    _lastNameController.text = lastName;
    _emailController.text = UserData.email;
    _countryController.text = "Indonesia"; // Default country, can be changed
    _descriptionController.text = ""; // Default description, can be changed
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String email = _emailController.text.trim();
    String country = _countryController.text.trim();
    String description = _descriptionController.text.trim();

    // Validate input
    if (firstName.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Nama depan harus diisi")));
      return;
    }

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Email harus diisi")));
      return;
    }

    // Basic email validation
    if (!email.contains("@")) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Format email tidak valid")));
      return;
    }

    // Combine first name and last name
    String fullName = firstName;
    if (lastName.isNotEmpty) {
      fullName += " $lastName";
    }

    // Check if email is being changed and if new email already exists
    if (email != UserData.email) {
      bool emailExists = await UserData.userExists(email);
      if (emailExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email sudah digunakan oleh akun lain")),
        );
        return;
      }
    }

    // Update user data in shared preferences
    await UserData.updateUser(fullName, email, UserData.password);

    // Update in-memory data
    UserData.name = fullName;
    UserData.email = email;

    // Update controllers with new values
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeControllers();
    });

    // Show success message
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profil berhasil diperbarui")));

    // Navigate back to home screen after a short delay
    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.pop(context); // This will go back to the previous screen (home)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 3,
        child: Stack(
          children: [
            // Background Header
            Container(
              height: 280,
              width: double.infinity,
              color: kPrimaryColor,
            ),
            
            // Main Content
            SafeArea(
              child: Column(
                children: [
                  // Custom AppBar (Back Button + Title)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Text(
                          "Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Profile Header Content
                  Column(
                    children: [
                      // Profile Image
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[200],
                           // Removed missing asset reference
                          child: Icon(Icons.person, size: 60, color: Colors.grey[400]), 
                        ),
                      ),
                      const SizedBox(height: 16),
                      // User Name
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

                  const SizedBox(height: 30),

                  // Floating Card TabBar
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                           // Floating Card for TabBar
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            transform: Matrix4.translationValues(0, -25, 0), // Move up to float
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: TabBar(
                              controller: _tabController,
                              labelColor: kPrimaryColor, // Changed to Blue
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: kPrimaryColor, // Changed to Blue
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorWeight: 3,
                              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                              tabs: const [
                                Tab(text: "About Me"),
                                Tab(text: "Kelas"),
                                Tab(text: "Edit Profile"),
                              ],
                            ),
                          ),
                          
                          // TabBar View
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                _buildAboutMeTab(),
                                _buildKelasTab(),
                                _buildEditProfileTab(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutMeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Informasi User",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInfoItem(
            "Email address",
            UserData.email.isEmpty ? "email@example.com" : UserData.email,
          ),
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
          _buildInfoItem(
            "First access to site",
            "Monday, 7 September 2020, 9:27 AM",
          ),
          const SizedBox(height: 16),
          _buildInfoItem("Last access to site", "Now"),

          const SizedBox(height: 32),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () async {
                await UserData.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text("Log Out"),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildKelasTab() {
    final List<Map<String, String>> classes = [
      {
        "code": "D4SM-41-GAB1 [ARS]",
        "name": "BAHASA INGGRIS: BUSINESS AND SCIENTIFIC",
        "date": "Monday, 8 February 2021",
      },
      {
        "code": "D4SM-42-03 [ADY]",
        "name": "DESAIN ANTARMUKA",
        "date": "Monday, 8 February 2021",
      },
      {
        "code": "D4SM-41-GAB1 [BBO]",
        "name": "KEWARGANEGARAAN",
        "date": "Monday, 8 February 2021",
      },
      {
        "code": "D3TT-44-02 [EYR]",
        "name": "OLAH RAGA",
        "date": "Monday, 8 February 2021",
      },
      {
        "code": "D4SM-42-03 [ADY]",
        "name": "PEMROGRAMAN MOBILE",
        "date": "Monday, 8 February 2021",
      },
      {
        "code": "D4SM-42-03 [ADY]",
        "name": "SISTEM OPERASI",
        "date": "Monday, 8 February 2021",
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final item = classes[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseDetailScreen(courseTitle: item['name']!),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
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
          ),
        );
      },
    );
  }

  Widget _buildEditProfileTab() {
    return SingleChildScrollView(
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
            _buildTextField("Nama Pertama", controller: _firstNameController),
            const SizedBox(height: 16),
            _buildTextField("Nama Terakhir", controller: _lastNameController),
            const SizedBox(height: 16),
            _buildTextField("E-mail Address", controller: _emailController),
            const SizedBox(height: 16),
            _buildTextField("Negara", controller: _countryController),
            const SizedBox(height: 16),
            _buildTextField(
              "Deskripsi",
              controller: _descriptionController,
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _saveProfile();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor, // Blue to match theme
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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

  Widget _buildTextField(
    String label, {
    int maxLines = 1,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
