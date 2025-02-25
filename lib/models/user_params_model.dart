import 'package:simple_iam/constants/constants.dart';
import 'package:simple_iam/models/user_model.dart';

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
    this.offset = defaultOffset,
    this.limit = defaultLimit,
  });

  factory UserListParams.init() {
    return const UserListParams(
      offset: defaultOffset,
      limit: defaultLimit,
    );
  }

  factory UserListParams.fromJson(Map<String, dynamic> jsonData) {
    return UserListParams(
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      email: jsonData['email'],
      offset: int.parse(jsonData['offset']),
      limit: int.parse(jsonData['limit']),
    );
  }

  Map<String, dynamic> toJson() {
    var result = {
      'offset': offset.toString(),
      'limit': limit.toString(),
    };

    if (firstName != null && firstName!.isNotEmpty) {
      result = {...result, 'firstName': firstName!};
    }

    if (lastName != null && lastName!.isNotEmpty) {
      result = {...result, 'lastName': lastName!};
    }

    if (email != null && email!.isNotEmpty) {
      result = {...result, 'email': email!};
    }

    return result;
  }
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

  factory UserCreateReqBody.fromUser(User userData) {
    return UserCreateReqBody(
      firstName: userData.firstName,
      lastName: userData.lastName,
      username: userData.username,
      email: userData.email,
      password: userData.password,
    );
  }

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
