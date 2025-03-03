import 'package:simple_iam/models/user_model.dart';

class UserDetailScreenArgument {
  final User selectedUser;

  UserDetailScreenArgument({
    required this.selectedUser,
  });
}

class UserUpdateScreenArgument {
  final User selectedUser;

  UserUpdateScreenArgument({
    required this.selectedUser,
  });
}
