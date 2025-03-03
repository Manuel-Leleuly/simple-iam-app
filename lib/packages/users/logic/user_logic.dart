import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_iam/api/user_api.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/models/user_params_model.dart';
import 'package:simple_iam/packages/users/providers/users_provider.dart';
import 'package:simple_iam/providers/token_provider.dart';

class UserLogic {
  final bool isFetchingUsers;
  final bool isUpdatingUser;
  final bool isDeletingUser;

  final Future<void> Function([UserListParams? params]) fetchUsers;
  final Future<void> Function({
    required String userId,
    required UserUpdateReqBody reqBody,
    required void Function(User updatedUser) onUserUpdateSuccess,
  }) updateUser;
  final Future<void> Function({
    required String userId,
    required VoidCallback onDeleteSuccess,
  }) deleteUser;

  UserLogic({
    required this.isFetchingUsers,
    required this.isUpdatingUser,
    required this.isDeletingUser,
    required this.fetchUsers,
    required this.updateUser,
    required this.deleteUser,
  });
}

UserLogic useUserLogic(WidgetRef ref) {
  final isFetchingUsers = useState<bool>(false);
  final isUpdatingUser = useState<bool>(false);
  final isDeletingUser = useState<bool>(false);

  final usersNotifier = ref.read(usersProvider.notifier);
  final token = ref.watch(tokenProvider);
  final userApi = UserApi(token.accessToken);

  Future<void> fetchUsers([UserListParams? params]) async {
    try {
      isFetchingUsers.value = true;
      usersNotifier.users = [];
      final response = await userApi.getUserList(params);
      if (response == null) return;
      usersNotifier.users = response.data;
    } finally {
      isFetchingUsers.value = false;
    }
  }

  Future<void> updateUser({
    required String userId,
    required UserUpdateReqBody reqBody,
    required void Function(User updatedUser) onUserUpdateSuccess,
  }) async {
    try {
      isUpdatingUser.value = true;
      final response = await userApi.updateUser(userId, reqBody);
      if (response == null) return;
      usersNotifier.updateUser(response);
      onUserUpdateSuccess(response);
    } finally {
      isUpdatingUser.value = false;
    }
  }

  Future<void> deleteUser({
    required String userId,
    required VoidCallback onDeleteSuccess,
  }) async {
    try {
      isDeletingUser.value = true;
      final response = await userApi.removeUser(userId);
      if (response == null) return;
      usersNotifier.deleteUser(userId);
      onDeleteSuccess();
    } finally {
      isDeletingUser.value = false;
    }
  }

  return UserLogic(
    isFetchingUsers: isFetchingUsers.value,
    isUpdatingUser: isUpdatingUser.value,
    isDeletingUser: isDeletingUser.value,
    fetchUsers: fetchUsers,
    updateUser: updateUser,
    deleteUser: deleteUser,
  );
}
