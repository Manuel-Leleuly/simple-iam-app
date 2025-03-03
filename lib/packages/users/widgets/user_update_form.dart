import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/packages/users/logic/user_form_logic.dart';

class UserUpdateForm extends HookWidget {
  final User user;
  final UserFormLogic userFormLogic;

  const UserUpdateForm({
    super.key,
    required this.user,
    required this.userFormLogic,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: userFormLogic.formKey,
      child: Column(
        children: [
          TextFormField(
            maxLength: 15,
            decoration: const InputDecoration(
              labelText: 'First Name',
            ),
            controller: userFormLogic.firstNameController,
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLength: 15,
            decoration: const InputDecoration(
              labelText: 'Last Name',
            ),
            controller: userFormLogic.lastNameController,
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLength: 30,
            decoration: const InputDecoration(labelText: 'Username'),
            controller: userFormLogic.usernameController,
          ),
        ],
      ),
    );
  }
}
