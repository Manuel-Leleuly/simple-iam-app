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
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        username: _userNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
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
            controller: _firstNameController,
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLength: 15,
            decoration: const InputDecoration(
              labelText: 'Last Name',
            ),
            validator: authValidator.validateLastName,
            controller: _lastNameController,
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLength: 30,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            validator: authValidator.validateUsername,
            controller: _userNameController,
          ),
          const SizedBox(height: 8),
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
            validator: authValidator.validatePassword,
            controller: _passwordController,
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
