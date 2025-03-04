import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_iam/api/auth_api.dart';
import 'package:simple_iam/packages/auth/validator/auth_validator.dart';
import 'package:simple_iam/packages/users/logic/user_form_logic.dart';
import 'package:simple_iam/widgets/form/field_label.dart';
import 'package:simple_iam/widgets/form/password_form_field.dart';

const authValidator = AuthValidator();
const authApi = AuthApi();

class LoginForm extends HookConsumerWidget {
  final UserFormLogic userFormLogic;

  const LoginForm({
    super.key,
    required this.userFormLogic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: userFormLogic.formKey,
      child: Column(
        children: [
          TextFormField(
            key: const ValueKey('login_email'),
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
            passwordFieldKey: const ValueKey('login_password'),
            passwordController: userFormLogic.passwordController,
            validatePassword: (value) {
              return authValidator.validatePassword(
                value,
                isLogin: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
