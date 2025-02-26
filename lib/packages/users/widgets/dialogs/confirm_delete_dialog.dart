import 'package:flutter/material.dart';
import 'package:simple_iam/models/user_model.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final User user;
  final void Function(User selectedUser) onConfirm;
  final VoidCallback onCancel;
  final bool isLoading;

  const ConfirmDeleteDialog({
    super.key,
    required this.user,
    required this.onConfirm,
    required this.onCancel,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete User'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Are you sure you want to remove ${user.username}?'),
          const SizedBox(height: 10),
          const Text('This action cannot be undone.'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => onConfirm(user),
          child: switch (isLoading) {
            true => const CircularProgressIndicator(),
            false => const Text('Remove')
          },
        ),
      ],
    );
  }
}
