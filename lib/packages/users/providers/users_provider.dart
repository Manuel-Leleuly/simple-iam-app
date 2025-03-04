import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_iam/models/user_model.dart';

part 'users_provider.g.dart';

@riverpod
class UsersNotifier extends _$UsersNotifier {
  @override
  List<User> build() {
    return [];
  }

  set users(List<User> newUsers) {
    state = newUsers;
  }

  void updateUser(User updatedUser) {
    final newUsers = List<User>.from(state);
    final selectedUserIndex = newUsers.indexWhere(
      (user) => user.id == updatedUser.id,
    );

    newUsers[selectedUserIndex] = updatedUser;

    state = newUsers;
  }

  void deleteUser(String userId) {
    state = state.where((user) => user.id != userId).toList();
  }
}
