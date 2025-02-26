import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:simple_iam/api/user_api.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/models/user_params_model.dart';

class UserLogic {
  final bool isFetchingUsers;
  final bool isDeletingUser;

  final List<User> users;

  final Future<void> Function([UserListParams? params]) fetchUsers;
  final Future<void> Function({
    required String userId,
    required VoidCallback onDeleteSuccess,
  }) deleteUser;

  UserLogic({
    required this.isFetchingUsers,
    required this.isDeletingUser,
    required this.users,
    required this.fetchUsers,
    required this.deleteUser,
  });
}

// TODO: improve this so that it doesn't need access token
UserLogic useUserLogic(String accessToken) {
  final isFetchingUsers = useState<bool>(false);
  final isDeletingUser = useState<bool>(false);

  final users = useState<List<User>>([]);
  final userApi = UserApi(accessToken);

  Future<void> fetchUsers([UserListParams? params]) async {
    try {
      isFetchingUsers.value = true;
      users.value = [];
      final response = await userApi.getUserList(params);
      if (response != null) {
        users.value = response.data;
      }
    } finally {
      isFetchingUsers.value = false;
    }
  }

  Future<void> deleteUser({
    required String userId,
    required VoidCallback onDeleteSuccess,
  }) async {
    try {
      isDeletingUser.value = true;
      final response = await userApi.removeUser(userId);
      if (response != null) {
        users.value = users.value
            .where(
              (user) => user.id != userId,
            )
            .toList();
        onDeleteSuccess();
      }
    } finally {
      isDeletingUser.value = false;
    }
  }

  return UserLogic(
    isFetchingUsers: isFetchingUsers.value,
    isDeletingUser: isDeletingUser.value,
    users: users.value,
    fetchUsers: fetchUsers,
    deleteUser: deleteUser,
  );
}
