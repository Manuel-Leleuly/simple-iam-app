import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:simple_iam/models/user_model.dart';

class UserFormLogic {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  UserFormLogic({
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  });
}

UserFormLogic useUserFormLogic({User? defaultValues}) {
  final formKey = useMemoized(() => GlobalKey<FormState>(), []);
  final firstName = useTextEditingController();
  final lastName = useTextEditingController();
  final username = useTextEditingController();
  final email = useTextEditingController();
  final password = useTextEditingController();

  if (defaultValues != null) {
    firstName.text = defaultValues.firstName;
    lastName.text = defaultValues.lastName;
    username.text = defaultValues.username;
    email.text = defaultValues.email;
    password.text = defaultValues.password;
  }

  return UserFormLogic(
    formKey: formKey,
    firstNameController: firstName,
    lastNameController: lastName,
    usernameController: username,
    emailController: email,
    passwordController: password,
  );
}
