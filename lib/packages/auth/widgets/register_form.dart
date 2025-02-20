import 'package:flutter/material.dart';
import 'package:simple_iam/api/user_api.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/models/user_params_model.dart';
import 'package:simple_iam/packages/auth/validator/auth_validator.dart';

const authValidator = AuthValidator();
const userApi = UserApi();

class RegisterForm extends StatefulWidget {
  final VoidCallback onRegisterSuccess;

  const RegisterForm({
    super.key,
    required this.onRegisterSuccess,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _userName = '';
  String _email = '';
  String _password = '';

  bool _isLoading = false;

  void _onRegisterSubmit() async {
    FocusScope.of(context).unfocus();
    final isAllValid = _formKey.currentState!.validate();
    if (!isAllValid) return;

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final newUser = User.newUser(
        firstName: _firstName,
        lastName: _lastName,
        username: _userName,
        email: _email,
        password: _password,
      );

      final reqBody = UserCreateReqBody.fromUser(newUser);
      await userApi.createUser(reqBody);

      widget.onRegisterSuccess();
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
            maxLength: 15,
            decoration: const InputDecoration(
              labelText: 'First Name',
            ),
            validator: authValidator.validateFirstName,
            initialValue: _firstName,
            onSaved: (newValue) => _firstName = newValue!,
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLength: 15,
            decoration: const InputDecoration(
              labelText: 'Last Name',
            ),
            validator: authValidator.validateLastName,
            initialValue: _lastName,
            onSaved: (newValue) => _lastName = newValue!,
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLength: 30,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            validator: authValidator.validateUsername,
            initialValue: _userName,
            onSaved: (newValue) => _userName = newValue!,
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLength: 20,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            validator: authValidator.validateEmail,
            keyboardType: TextInputType.emailAddress,
            initialValue: _email,
            onSaved: (newValue) {
              _email = newValue!;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            initialValue: _password,
            validator: authValidator.validatePassword,
            onSaved: (newValue) => _password = newValue!,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : _onRegisterSubmit,
            child: switch (_isLoading) {
              true => const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(),
                ),
              false => const Text('Register'),
            },
          )
        ],
      ),
    );
  }
}
