class UserModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String audioCallToken;

  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.audioCallToken,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      audioCallToken: data['audioCallToken'] ?? '',
    );
  }
}
