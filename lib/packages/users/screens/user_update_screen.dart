import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_iam/models/user_params_model.dart';
import 'package:simple_iam/packages/users/logic/user_form_logic.dart';
import 'package:simple_iam/packages/users/logic/user_logic.dart';
import 'package:simple_iam/packages/users/providers/users_provider.dart';
import 'package:simple_iam/packages/users/widgets/user_update_form.dart';
import 'package:simple_iam/widgets/button_child_with_loading.dart';

class UserUpdateScreen extends HookConsumerWidget {
  final String userId;

  const UserUpdateScreen({
    super.key,
    required this.userId,
  });

  static const routeName = '/users/update';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider);
    final user = users.firstWhere((user) => user.id == userId);
    final userFormLogic = useUserFormLogic(defaultValues: user);
    final userLogic = useUserLogic(ref);

    Future<void> onUpdateButtonPressed() async {
      final formKey = userFormLogic.formKey;
      final isAllValid = formKey.currentState!.validate();
      if (!isAllValid) return;
      formKey.currentState!.save();

      await userLogic.updateUser(
        userId: user.id,
        reqBody: UserUpdateReqBody(
          firstName: userFormLogic.firstNameController.text,
          lastName: userFormLogic.lastNameController.text,
          username: userFormLogic.usernameController.text,
        ),
        onUserUpdateSuccess: (updatedUser) {
          Navigator.of(context).pop();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Update ${user.username}'),
        actions: [
          IconButton(
            icon: ButtonChildWithLoading(
              isLoading: userLogic.isUpdatingUser,
              child: const Icon(Icons.save),
            ),
            onPressed: onUpdateButtonPressed,
          ),
        ],
      ),
      body: Center(
        child: UserUpdateForm(
          user: user,
          userFormLogic: userFormLogic,
        ),
      ),
    );
  }
}
