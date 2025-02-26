import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_iam/api/user_api.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/providers/token_provider.dart';

class UserCard extends HookConsumerWidget {
  final User user;
  final void Function(User selectedUser)? onUserTap;
  final void Function(User selectedUser)? onDeleteUser;

  const UserCard({
    super.key,
    required this.user,
    this.onUserTap,
    this.onDeleteUser,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(tokenProvider);
    final userApi = UserApi(token.accessToken);

    return GestureDetector(
      onTap: onUserTap != null ? () => onUserTap!(user) : null,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '(${user.username})',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .color!
                                  .withValues(
                                    alpha: 0.8,
                                  ),
                            ),
                      )
                    ],
                  ),
                  Text(user.email),
                ],
              ),
              if (onDeleteUser != null)
                IconButton(
                  onPressed: () => onDeleteUser!(user),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
