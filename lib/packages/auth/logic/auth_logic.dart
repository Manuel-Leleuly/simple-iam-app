import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_iam/api/auth_api.dart';
import 'package:simple_iam/models/auth_model.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/models/user_params_model.dart';
import 'package:simple_iam/packages/auth/widgets/register_form.dart';
import 'package:simple_iam/providers/token_provider.dart';

const authApi = AuthApi();

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

  final formKey = useMemoized(() => GlobalKey<FormState>(), []);
  final firstName = useTextEditingController();
  final lastName = useTextEditingController();
  final username = useTextEditingController();
  final email = useTextEditingController();
  final password = useTextEditingController();

  void onLoginSubmit(VoidCallback onSubmitAccess) async {
    FocusScope.of(context).unfocus();
    final isAllValid = formKey.currentState!.validate();
    if (!isAllValid) return;

    formKey.currentState!.save();

    isLoading.value = true;

    try {
      final loginData = Login(
        email: email.text,
        password: password.text,
      );
      final response = await authApi.login(loginData);
      if (response == null) return;

      ref.read(tokenProvider.notifier).setToken(response);
      onSubmitAccess();
    } finally {
      isLoading.value = false;
    }
  }

  void onRegisterSubmit(VoidCallback onRegisterSuccess) async {
    FocusScope.of(context).unfocus();
    final isAllValid = formKey.currentState!.validate();
    if (!isAllValid) return;

    formKey.currentState!.save();

    isLoading.value = true;

    try {
      final newUser = User.newUser(
        firstName: firstName.text,
        lastName: lastName.text,
        username: username.text,
        email: email.text,
        password: password.text,
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
    formKey: formKey,
    firstNameController: firstName,
    lastNameController: lastName,
    usernameController: username,
    emailController: email,
    passwordController: password,
    onLoginSubmit: onLoginSubmit,
    onRegisterSubmit: onRegisterSubmit,
  );
}
