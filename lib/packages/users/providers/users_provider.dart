import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_iam/models/user_model.dart';

class UsersNotifier extends StateNotifier<List<User>> {
  UsersNotifier() : super([]);

  set users(List<User> newUsers) {
    state = newUsers;
  }

  void updateUser(User updatedUser) {
    final newUsers = List<User>.from(state);
    final selectedUserIndex =
        newUsers.indexWhere((user) => user.id == updatedUser.id);

    newUsers[selectedUserIndex] = updatedUser;

    state = newUsers;
  }

  void deleteUser(String userId) {
    state = state.where((user) => user.id != userId).toList();
  }
}

final usersProvider = StateNotifierProvider<UsersNotifier, List<User>>(
  (ref) => UsersNotifier(),
);
