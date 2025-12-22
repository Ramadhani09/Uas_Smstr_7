import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static String name = "Mahasiswa";
  static String email = "";
  static String password = "";
  static bool isRegistered = false;

  /// Loads user data from persistent storage
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? "Mahasiswa";
    email = prefs.getString('email') ?? "";
    password = prefs.getString('password') ?? "";
    isRegistered = prefs.getBool('isRegistered') ?? false;
  }

  /// Saves user data to persistent storage
  static Future<void> saveUser(String newName, String newEmail, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', newName);
    await prefs.setString('email', newEmail);
    await prefs.setString('password', newPassword);
    await prefs.setBool('isRegistered', true);

    // Update in-memory data
    name = newName;
    email = newEmail;
    password = newPassword;
    isRegistered = true;
  }
}
