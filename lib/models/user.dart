class User {
  final String id;
  final String name;
  final String email;
  final String role; // 'student', 'teacher', etc.

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'role': role,
  };

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map['id'],
    name: map['name'],
    email: map['email'],
    role: map['role'],
  );
}
