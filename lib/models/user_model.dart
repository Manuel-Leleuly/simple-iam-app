class User {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
    this.createdAt,
    this.updatedAt,
  });

  factory User.init() {
    return const User(
      id: '',
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      password: '',
    );
  }

  factory User.newUser({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
  }) {
    return User(
      id: '',
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      password: password,
    );
  }

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData['id'],
      firstName: jsonData['first_name'],
      lastName: jsonData['last_name'],
      username: jsonData['username'],
      email: jsonData['email'],
      password: jsonData['password'] ?? '',
      createdAt: DateTime.parse(jsonData['created_at']),
      updatedAt: DateTime.parse(jsonData['updated_at']),
    );
  }

  User copyWith({String? firstName, String? lastName, String? username}) {
    return User(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email,
      password: password,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toJsonCreate() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
    };
  }
}

// helper functions
List<User> getUserListFromJsonResponse(List<dynamic> jsonData) {
  List<User> users = [];

  for (var userData in jsonData) {
    users.add(User.fromJson(userData));
  }

  return users;
}
