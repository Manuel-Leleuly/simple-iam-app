import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_iam/api/auth_api.dart';
import 'package:simple_iam/api/user_api.dart';
import 'package:simple_iam/models/auth_model.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/models/user_params_model.dart';
import 'package:simple_iam/packages/users/logic/user_form_logic.dart';
import 'package:simple_iam/providers/token_provider.dart';

const authApi = AuthApi();
const userApi = UserApi();

class AuthLogic {
  final bool isLoading;

  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final void Function(VoidCallback onSubmitSuccess) onLoginSubmit;
  final void Function(VoidCallback onRegisterSuccess) onRegisterSubmit;

  AuthLogic({
    required this.isLoading,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.onLoginSubmit,
    required this.onRegisterSubmit,
  });
}

AuthLogic useAuthLogic(BuildContext context, WidgetRef ref) {
  final isLoading = useState(false);

  final userCreationLogic = useUserFormLogic();

  void onLoginSubmit(VoidCallback onSubmitSuccess) async {
    FocusScope.of(context).unfocus();
    final isAllValid = userCreationLogic.formKey.currentState!.validate();
    if (!isAllValid) return;

    userCreationLogic.formKey.currentState!.save();

    isLoading.value = true;

    try {
      final loginData = Login(
        email: userCreationLogic.emailController.text,
        password: userCreationLogic.passwordController.text,
      );
      final response = await authApi.login(loginData);
      if (response == null) return;

      ref.read(tokenProvider.notifier).setToken(response);
      onSubmitSuccess();
    } finally {
      isLoading.value = false;
    }
  }

  void onRegisterSubmit(VoidCallback onRegisterSuccess) async {
    FocusScope.of(context).unfocus();
    final isAllValid = userCreationLogic.formKey.currentState!.validate();
    if (!isAllValid) return;

    userCreationLogic.formKey.currentState!.save();

    isLoading.value = true;

    try {
      final newUser = User.newUser(
        firstName: userCreationLogic.firstNameController.text,
        lastName: userCreationLogic.lastNameController.text,
        username: userCreationLogic.usernameController.text,
        email: userCreationLogic.emailController.text,
        password: userCreationLogic.passwordController.text,
      );
      final reqBody = UserCreateReqBody.fromUser(newUser);
      await userApi.createUser(reqBody);

      onRegisterSuccess();
    } finally {
      isLoading.value = false;
    }
  }

  return AuthLogic(
    isLoading: isLoading.value,
    formKey: userCreationLogic.formKey,
    firstNameController: userCreationLogic.firstNameController,
    lastNameController: userCreationLogic.lastNameController,
    usernameController: userCreationLogic.usernameController,
    emailController: userCreationLogic.emailController,
    passwordController: userCreationLogic.passwordController,
    onLoginSubmit: onLoginSubmit,
    onRegisterSubmit: onRegisterSubmit,
  );
}
