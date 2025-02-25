import 'package:flutter/material.dart';
import 'package:simple_iam/models/user_model.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            blurStyle: BlurStyle.inner,
            blurRadius: 7,
            spreadRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      // TODO: improve this
      child: Column(
        children: [
          Text(user.firstName),
          Text(user.lastName),
          Text(user.username),
          Text(user.email),
        ],
      ),
    );
  }
}
