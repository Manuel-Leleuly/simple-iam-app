import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_iam/helpers/snackbar_helper.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/models/user_params_model.dart';
import 'package:simple_iam/packages/users/logic/user_logic.dart';
import 'package:simple_iam/packages/users/models/argument_model.dart';
import 'package:simple_iam/packages/users/screens/user_detail_screen.dart';
import 'package:simple_iam/packages/users/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:simple_iam/packages/users/widgets/user_card.dart';
import 'package:simple_iam/providers/token_provider.dart';
import 'package:simple_iam/widgets/app_bar_title.dart';

class UserListScreen extends HookConsumerWidget {
  const UserListScreen({super.key});

  static const routeName = '/users';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserListParams params = UserListParams.init();
    final token = ref.watch(tokenProvider);
    final userLogic = useUserLogic(token.accessToken);

    useEffect(
      () {
        userLogic.fetchUsers(params);
        return null;
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: 'Users'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () => userLogic.fetchUsers(params),
        child: UserListContent(
          users: userLogic.users,
          isLoading: userLogic.isFetchingUsers,
          onDeleteUser: (selectedUser) {
            showDialog(
              context: context,
              builder: (context) {
                return ConfirmDeleteDialog(
                  user: selectedUser,
                  isLoading: userLogic.isDeletingUser,
                  onCancel: Navigator.of(context).pop,
                  onConfirm: (selectedUser) {
                    userLogic.deleteUser(
                      userId: selectedUser.id,
                      onDeleteSuccess: () {
                        showSnackBar(
                          context: context,
                          snackBar: SnackBar(
                            content: Text(
                              '${selectedUser.username} is successfully deleted',
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// helper widgets
class UserListContent extends StatelessWidget {
  final List<User> users;
  final bool isLoading;
  final void Function(User selectedUser) onDeleteUser;

  const UserListContent({
    super.key,
    required this.users,
    required this.isLoading,
    required this.onDeleteUser,
  });

  void _onUserTap(BuildContext context, User selectedUser) {
    Navigator.pushNamed(
      context,
      UserDetailScreen.routeName,
      arguments: UserDetailScreenArgument(selectedUser: selectedUser),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => UserCard(
        user: users[index],
        onUserTap: (selectedUser) => _onUserTap(context, selectedUser),
        onDeleteUser: onDeleteUser,
      ),
    );
  }
}
