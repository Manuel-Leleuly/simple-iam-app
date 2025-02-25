import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:simple_iam/api/user_api.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/models/user_params_model.dart';

class UserLogic {
  final bool isLoading;

  final List<User> users;

  final Future<void> Function([UserListParams? params]) fetchUsers;

  UserLogic({
    required this.isLoading,
    required this.users,
    required this.fetchUsers,
  });
}

// TODO: improve this so that it doesn't need access token
UserLogic useUserLogic(String accessToken) {
  final isLoading = useState<bool>(false);
  final users = useState<List<User>>([]);
  final userApi = UserApi(accessToken);

  Future<void> fetchUsers([UserListParams? params]) async {
    try {
      isLoading.value = true;
      users.value = [];
      final response = await userApi.getUserList(params);
      if (response != null) {
        users.value = response.data;
      }
    } finally {
      isLoading.value = false;
    }
  }

  return UserLogic(
    isLoading: isLoading.value,
    users: users.value,
    fetchUsers: fetchUsers,
  );
}
