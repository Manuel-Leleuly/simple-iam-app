import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_iam/packages/auth/validator/auth_validator.dart';
import 'package:simple_iam/packages/users/logic/user_form_logic.dart';
import 'package:simple_iam/widgets/form/field_label.dart';
import 'package:simple_iam/widgets/form/password_form_field.dart';

const authValidator = AuthValidator();

class RegisterForm extends HookConsumerWidget {
  final UserFormLogic userFormLogic;

  const RegisterForm({
    super.key,
    required this.userFormLogic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: userFormLogic.formKey,
      child: Column(
        children: [
          TextFormField(
            key: const ValueKey('register_first_name'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 15,
            decoration: const InputDecoration(
              label: FieldLabel(
                label: Text('First Name'),
                isRequired: true,
              ),
            ),
            textCapitalization: TextCapitalization.words,
            validator: authValidator.validateFirstName,
            controller: userFormLogic.firstNameController,
          ),
          const SizedBox(height: 8),
          TextFormField(
            key: const ValueKey('register_last_name'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 15,
            decoration: const InputDecoration(
              label: FieldLabel(
                label: Text('Last Name'),
              ),
            ),
            textCapitalization: TextCapitalization.words,
            validator: authValidator.validateLastName,
            controller: userFormLogic.lastNameController,
          ),
          const SizedBox(height: 8),
          TextFormField(
            key: const ValueKey('register_username'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 30,
            decoration: const InputDecoration(
              label: FieldLabel(
                label: Text('Username'),
                isRequired: true,
              ),
            ),
            validator: authValidator.validateUsername,
            controller: userFormLogic.usernameController,
          ),
          const SizedBox(height: 8),
          TextFormField(
            key: const ValueKey('register_email'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 20,
            decoration: const InputDecoration(
              label: FieldLabel(
                label: Text('Email'),
                isRequired: true,
              ),
            ),
            validator: authValidator.validateEmail,
            keyboardType: TextInputType.emailAddress,
            controller: userFormLogic.emailController,
          ),
          const SizedBox(height: 8),
          PasswordFormField(
            passwordFieldKey: const ValueKey('register_password'),
            passwordController: userFormLogic.passwordController,
            validatePassword: authValidator.validatePassword,
          ),
        ],
      ),
    );
  }
}
