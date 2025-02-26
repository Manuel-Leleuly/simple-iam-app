import 'package:flutter/material.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/widgets/app_bar_title.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({
    super.key,
    required this.user,
  });

  static const routeName = '/users/detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: '${user.firstName} ${user.lastName}'),
        backgroundColor: Theme.of(context).primaryColor,
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
