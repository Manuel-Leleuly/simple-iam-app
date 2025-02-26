import 'package:simple_iam/constants/constants.dart';
import 'package:simple_iam/helpers/object_helper.dart';
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
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'offset': offset.toString(),
      'limit': limit.toString(),
    };

    return ObjectHelper.cleanObject(result);
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
      'last_name': lastName,
      'username': username,
      'email': email,
      'password': password,
    };

    return ObjectHelper.cleanObject(result);
  }
}

class UserUpdateReqBody {
  final String? firstName;
  final String? lastName;
  final String? username;

  UserUpdateReqBody({
    required this.firstName,
    required this.lastName,
    required this.username,
  });

  factory UserUpdateReqBody.fromUser(User user) {
    return UserUpdateReqBody(
      firstName: user.firstName,
      lastName: user.lastName,
      username: user.lastName,
    );
  }

  Map<String, dynamic> toJson() {
    var result = {
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
    };

    return ObjectHelper.cleanObject(result);
  }
}
