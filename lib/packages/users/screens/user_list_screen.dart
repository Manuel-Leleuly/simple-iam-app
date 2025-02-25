import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/models/user_params_model.dart';
import 'package:simple_iam/packages/users/logic/user_logic.dart';
import 'package:simple_iam/packages/users/widgets/user_card.dart';
import 'package:simple_iam/providers/token_provider.dart';

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
        title: const Text('Users'),
        backgroundColor: Colors.blue,
      ),
      body: UserListContent(
        users: userLogic.users,
        isLoading: userLogic.isLoading,
      ),
    );
  }
}

// helper widgets
class UserListContent extends StatelessWidget {
  final List<User> users;
  final bool isLoading;

  const UserListContent({
    super.key,
    required this.users,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => UserCard(user: users[index]),
    );
  }
}
