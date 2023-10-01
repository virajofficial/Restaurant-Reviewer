class User {
  final int userId;
  final String name;
  final String userName;
  final String contactNo;
  final String email;

  User({
    this.userId = 0,
    required this.name,
    required this.userName,
    required this.contactNo,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      userId: parsedJson['id'],
      name: parsedJson['name'],
      userName: parsedJson['userName'],
      contactNo: parsedJson['contactNumber'],
      email: parsedJson['email'],
    );
  }
}
