import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_iam/api/auth_api.dart';
import 'package:simple_iam/models/auth_model.dart';
import 'package:simple_iam/packages/auth/validator/auth_validator.dart';
import 'package:simple_iam/providers/token_provider.dart';

const authValidator = AuthValidator();
const authApi = AuthApi();

class LoginForm extends ConsumerStatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginForm({
    super.key,
    required this.onLoginSuccess,
  });

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginSubmit() async {
    FocusScope.of(context).unfocus();
    final isAllValid = _formKey.currentState!.validate();
    if (!isAllValid) return;

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final loginData = Login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final response = await authApi.login(loginData);

      if (response != null) {
        ref.read(tokenProvider.notifier).setToken(response);
        widget.onLoginSuccess();
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            maxLength: 20,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            validator: authValidator.validateEmail,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            controller: _passwordController,
            validator: (value) {
              return authValidator.validatePassword(
                value,
                isLogin: true,
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : _onLoginSubmit,
            child: switch (_isLoading) {
              true => const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(),
                ),
              false => const Text('Login'),
            },
          ),
        ],
      ),
    );
  }
}
