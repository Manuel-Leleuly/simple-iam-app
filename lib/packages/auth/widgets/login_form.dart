import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_iam/api/auth_api.dart';
import 'package:simple_iam/packages/auth/logic/auth_logic.dart';
import 'package:simple_iam/packages/auth/validator/auth_validator.dart';
import 'package:simple_iam/widgets/button_child_with_loading.dart';

const authValidator = AuthValidator();
const authApi = AuthApi();

class LoginForm extends HookConsumerWidget {
  final VoidCallback onLoginSuccess;

  const LoginForm({
    super.key,
    required this.onLoginSuccess,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authLogic = useAuthLogic(context, ref);

    return Form(
      key: authLogic.formKey,
      child: Column(
        children: [
          TextFormField(
            maxLength: 20,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            validator: authValidator.validateEmail,
            keyboardType: TextInputType.emailAddress,
            controller: authLogic.emailController,
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            controller: authLogic.passwordController,
            validator: (value) {
              return authValidator.validatePassword(
                value,
                isLogin: true,
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: authLogic.isLoading
                ? null
                : () => authLogic.onLoginSubmit(onLoginSuccess),
            child: ButtonChildWithLoading(
              isLoading: authLogic.isLoading,
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
