class UserListParams {
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? offset;
  final int? limit;

  const UserListParams({
    this.firstName,
    this.lastName,
    this.email,
    this.offset = 0,
    this.limit = 10,
  });

  factory UserListParams.fromJson(Map<String, dynamic> jsonData) {
    return UserListParams(
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      email: jsonData['email'],
      offset: int.parse(jsonData['offset']),
      limit: int.parse(jsonData['limit']),
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'offset': offset.toString(),
        'limit': limit.toString(),
      };
}

class UserCreateReqBody {
  final String firstName;
  final String? lastName;
  final String username;
  final String email;
  final String password;

  const UserCreateReqBody({
    required this.firstName,
    this.lastName,
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    var result = {
      'first_name': firstName,
      'username': username,
      'email': email,
      'password': password,
    };

    if (lastName != null) {
      result = {...result, 'last_name': lastName!};
    }

    return result;
  }
}
