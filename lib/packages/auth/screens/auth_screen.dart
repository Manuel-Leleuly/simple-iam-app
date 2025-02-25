import 'package:flutter/material.dart';
import 'package:simple_iam/helpers/snackbar_helper.dart';
import 'package:simple_iam/packages/auth/widgets/login_form.dart';
import 'package:simple_iam/packages/auth/widgets/register_form.dart';

enum FormType { login, register }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  FormType _selectedForm = FormType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _selectedForm == FormType.login ? 'LOGIN' : 'REGISTER',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (_selectedForm == FormType.login)
              LoginForm(
                onLoginSuccess: () {
                  showSnackBar(
                    context: context,
                    snackBar: const SnackBar(
                      content: Text('Login successful'),
                    ),
                  );
                },
              )
            else
              RegisterForm(
                onRegisterSuccess: () {
                  showSnackBar(
                    context: context,
                    snackBar: const SnackBar(
                      content: Text('User successfully created!'),
                    ),
                  );
                  setState(() {
                    _selectedForm = FormType.login;
                  });
                },
              ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                setState(() {
                  if (_selectedForm == FormType.login) {
                    _selectedForm = FormType.register;
                  } else {
                    _selectedForm = FormType.login;
                  }
                });
              },
              child: Text(_selectedForm == FormType.login
                  ? 'Create a new account'
                  : 'I already have an account'),
            ),
          ],
        ),
      ),
    );
  }
}
