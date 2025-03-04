import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_iam/packages/users/models/argument_model.dart';
import 'package:simple_iam/packages/users/providers/users_provider.dart';
import 'package:simple_iam/packages/users/screens/user_update_screen.dart';

class UserDetailScreen extends ConsumerWidget {
  final String userId;

  const UserDetailScreen({
    super.key,
    required this.userId,
  });

  static const routeName = '/users/detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersNotifierProvider);
    final user = users.firstWhere((user) => user.id == userId);

    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                UserUpdateScreen.routeName,
                arguments: UserUpdateScreenArgument(selectedUser: user),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          DetailValue(label: 'First Name', value: user.firstName),
          DetailValue(label: 'Last Name', value: user.lastName),
          DetailValue(label: 'Username', value: user.username),
          DetailValue(label: 'Email', value: user.email),
        ],
      ),
    );
  }
}

// helper widgets
class DetailValue extends StatelessWidget {
  final String label;
  final String value;

  const DetailValue({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$label:'),
        const SizedBox(width: 10),
        Text(value),
      ],
    );
  }
}
