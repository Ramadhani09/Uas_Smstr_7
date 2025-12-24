import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static String name = "";
  static String email = "";
  static String password = "";
  static bool isLoggedIn = false;

  /// Loads user data from persistent storage
  static Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Debug: Check registered emails list
      List<String>? registeredEmails = prefs.getStringList('registered_emails');
      print(
        'UserData init - Registered emails exist: ${registeredEmails != null}, Count: ${registeredEmails?.length ?? 0}',
      );

      // Jika tidak ada email terdaftar, coba cek apakah ada data lama
      if (registeredEmails == null || registeredEmails.isEmpty) {
        // Coba cek apakah ada user data lama sebelum sistem multi-user
        String? currentName = prefs.getString('current_user_name');
        String? currentEmail = prefs.getString('current_user_email');
        String? currentPassword = prefs.getString('current_user_password');
        bool currentLoggedIn = prefs.getBool('is_logged_in') ?? false;

        if (currentEmail != null && currentEmail.isNotEmpty) {
          // Jika ada data login sebelumnya, tambahkan ke daftar terdaftar
          List<String> newRegisteredEmails = [currentEmail];
          await prefs.setStringList('registered_emails', newRegisteredEmails);
          print('Recovered user data for: $currentEmail');
        }
      }

      // Load current logged-in user data
      name = prefs.getString('current_user_name') ?? "";
      email = prefs.getString('current_user_email') ?? "";
      password = prefs.getString('current_user_password') ?? "";
      isLoggedIn = prefs.getBool('is_logged_in') ?? false;

      print(
        'UserData initialized - Name: $name, Email: $email, IsLoggedIn: $isLoggedIn',
      );
    } catch (e) {
      print('Error initializing user data: $e');
    }
  }

  /// Saves user data to persistent storage
  static Future<void> saveUser(
    String name,
    String email,
    String password,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Create unique key for this user
      String userKey =
          'user_${email.replaceAll('@', '_at_').replaceAll('.', '_dot_')}';
      Map<String, String> userData = {
        'name': name,
        'email': email,
        'password': password,
      };

      print('Saving user - Name: $name, Email: $email');

      // Save user data
      bool userSaveSuccess = await prefs.setString(
        userKey,
        json.encode(userData),
      );

      // Add email to list of registered users
      List<String> registeredEmails =
          prefs.getStringList('registered_emails') ?? [];
      if (!registeredEmails.contains(email)) {
        registeredEmails.add(email);
        bool listSaveSuccess = await prefs.setStringList(
          'registered_emails',
          registeredEmails,
        );
        if (listSaveSuccess) {
          print('Added email to registered list: $email');
        }
      }

      print('User saved with key: $userKey');
      print('Total registered emails: ${registeredEmails.length}');

      // Verify the save by reading it back
      List<String>? verifyList = prefs.getStringList('registered_emails');
      print(
        'Verified registered emails after save: ${verifyList?.length ?? 0}',
      );
    } catch (e) {
      print('Error saving user: $e');
    }
  }

  /// Attempts to login user
  static Future<bool> login(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      print('Login attempt - Email: $email, Password: $password');

      // Check registered emails list
      List<String>? registeredEmails = prefs.getStringList('registered_emails');
      print(
        'Total registered emails in list during login: ${registeredEmails?.length ?? 0}',
      );
      if (registeredEmails != null) {
        for (String regEmail in registeredEmails) {
          print('Registered email during login: $regEmail');
        }
      }

      // Create key for this user
      String userKey =
          'user_${email.replaceAll('@', '_at_').replaceAll('.', '_dot_')}';

      // Get the user data
      String? userJson = prefs.getString(userKey);
      print('Looking for user with key: $userKey');

      if (userJson != null) {
        Map<String, dynamic> user = json.decode(userJson);
        print('Found user: ${user['email']}');

        if (user['email'] == email && user['password'] == password) {
          // Set current user data
          name = user['name'];
          UserData.email = email;
          UserData.password = password;
          isLoggedIn = true;

          // Save current session
          bool nameSaveSuccess = await prefs.setString(
            'current_user_name',
            name,
          );
          bool emailSaveSuccess = await prefs.setString(
            'current_user_email',
            email,
          );
          bool passwordSaveSuccess = await prefs.setString(
            'current_user_password',
            password,
          );
          bool loginSaveSuccess = await prefs.setBool('is_logged_in', true);

          if (nameSaveSuccess &&
              emailSaveSuccess &&
              passwordSaveSuccess &&
              loginSaveSuccess) {
            print('Login successful for: $email');
            return true;
          } else {
            print('Failed to save login session');
            return false;
          }
        }
      }

      print('Login failed - no matching user found');
      return false;
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }

  /// Logs out current user
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    // Clear current session
    name = "";
    email = "";
    password = "";
    isLoggedIn = false;

    await prefs.remove('current_user_name');
    await prefs.remove('current_user_email');
    await prefs.remove('current_user_password');
    await prefs.setBool('is_logged_in', false);
  }

  /// Checks if a user with given email exists
  static Future<bool> userExists(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      print('Checking if user exists - Email: $email');

      // Check registered emails list first
      List<String>? registeredEmails = prefs.getStringList('registered_emails');
      print(
        'Total registered emails in list: ${registeredEmails?.length ?? 0}',
      );
      if (registeredEmails != null) {
        for (String regEmail in registeredEmails) {
          print('Registered email: $regEmail');
        }
      }

      // Create key for this user
      String userKey =
          'user_${email.replaceAll('@', '_at_').replaceAll('.', '_dot_')}';

      // Check if user data exists
      String? userJson = prefs.getString(userKey);

      print('Looking for user with key: $userKey');

      if (userJson != null) {
        print('User found: $email');
        return true;
      }

      print('User not found: $email');
      return false;
    } catch (e) {
      print('Error checking if user exists: $e');
      return false;
    }
  }

  /// Gets all registered users (for debugging purposes)
  static Future<List<Map<String, String>>> getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> registeredEmails =
        prefs.getStringList('registered_emails') ?? [];
    List<Map<String, String>> result = [];

    for (String email in registeredEmails) {
      String userKey =
          'user_${email.replaceAll('@', '_at_').replaceAll('.', '_dot_')}';
      String? userJson = prefs.getString(userKey);

      if (userJson != null) {
        Map<String, dynamic> user = json.decode(userJson);
        result.add({
          'name': user['name'],
          'email': user['email'],
          'password': user['password'],
        });
      }
    }

    return result;
  }

  /// Updates existing user information
  static Future<void> updateUser(
    String name,
    String email,
    String password,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    // Create key for this user
    String userKey =
        'user_${email.replaceAll('@', '_at_').replaceAll('.', '_dot_')}';

    // Check if user exists
    String? userJson = prefs.getString(userKey);

    if (userJson != null) {
      // Update user data
      Map<String, String> updatedUser = {
        'name': name,
        'email': email,
        'password': password,
      };

      await prefs.setString(userKey, json.encode(updatedUser));

      // If this is the currently logged-in user, update session data too
      if (isLoggedIn && UserData.email == email) {
        UserData.name = name;
        UserData.password = password;

        // Update session data
        await prefs.setString('current_user_name', name);
        await prefs.setString('current_user_email', email);
        await prefs.setString('current_user_password', password);
      }

      print('User updated: $email');
      return;
    }

    // If user not found, save as new user
    await saveUser(name, email, password);
  }
}
