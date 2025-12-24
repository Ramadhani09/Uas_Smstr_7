/// Model untuk data pengguna
class UserModel {
  final String name;
  final String email;
  final String
  password; // dalam implementasi sebenarnya, hindari menyimpan password dalam plain text
  final String? profilePicture;
  final String? studentId;
  final String? programOfStudy;
  final String? faculty;
  final DateTime? createdAt;
  final DateTime? lastLogin;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.profilePicture,
    this.studentId,
    this.programOfStudy,
    this.faculty,
    this.createdAt,
    this.lastLogin,
  });

  /// Konstruktor dari JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      profilePicture: json['profilePicture'],
      studentId: json['studentId'],
      programOfStudy: json['programOfStudy'],
      faculty: json['faculty'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      lastLogin: json['lastLogin'] != null
          ? DateTime.parse(json['lastLogin'])
          : null,
    );
  }

  /// Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
      'studentId': studentId,
      'programOfStudy': programOfStudy,
      'faculty': faculty,
      'createdAt': createdAt?.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  /// Copy with method untuk membuat salinan dengan perubahan tertentu
  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? profilePicture,
    String? studentId,
    String? programOfStudy,
    String? faculty,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePicture: profilePicture ?? this.profilePicture,
      studentId: studentId ?? this.studentId,
      programOfStudy: programOfStudy ?? this.programOfStudy,
      faculty: faculty ?? this.faculty,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}
