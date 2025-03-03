import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_iam/packages/auth/logic/auth_logic.dart';
import 'package:simple_iam/packages/auth/validator/auth_validator.dart';
import 'package:simple_iam/widgets/button_child_with_loading.dart';

const authValidator = AuthValidator();

class RegisterForm extends HookConsumerWidget {
  final VoidCallback onRegisterSuccess;

  const RegisterForm({
    super.key,
    required this.onRegisterSuccess,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authLogic = useAuthLogic(context, ref);

    return Form(
      key: authLogic.formKey,
      child: Column(
        children: [
          TextFormField(
            maxLength: 15,
            decoration: const InputDecoration(
              labelText: 'First Name',
            ),
            validator: authValidator.validateFirstName,
            controller: authLogic.firstNameController,
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLength: 15,
            decoration: const InputDecoration(
              labelText: 'Last Name',
            ),
            validator: authValidator.validateLastName,
            controller: authLogic.lastNameController,
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLength: 30,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            validator: authValidator.validateUsername,
            controller: authLogic.usernameController,
          ),
          const SizedBox(height: 8),
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
            validator: authValidator.validatePassword,
            controller: authLogic.passwordController,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: authLogic.isLoading
                ? null
                : () => authLogic.onRegisterSubmit(onRegisterSuccess),
            child: ButtonChildWithLoading(
              isLoading: authLogic.isLoading,
              child: const Text('Register'),
            ),
          )
        ],
      ),
    );
  }
}
