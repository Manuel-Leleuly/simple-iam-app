import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_iam/helpers/snackbar_helper.dart';
import 'package:simple_iam/models/auth_model.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/packages/auth/logic/auth_logic.dart';
import 'package:simple_iam/packages/auth/widgets/login_form.dart';
import 'package:simple_iam/packages/auth/widgets/register_form.dart';
import 'package:simple_iam/packages/users/logic/user_form_logic.dart';
import 'package:simple_iam/widgets/button_child_with_loading.dart';

enum FormType { login, register }

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authLogic = useAuthLogic(context, ref);
    final userFormLogic = useUserFormLogic();
    final selectedForm = useState(FormType.login);

    void onFormSubmit(FormType formType) {
      final isAllValid = userFormLogic.formKey.currentState!.validate();
      if (!isAllValid) return;

      userFormLogic.formKey.currentState!.save();

      if (formType == FormType.login) {
        authLogic.onLoginSubmit(
          loginData: Login(
            email: userFormLogic.emailController.text,
            password: userFormLogic.passwordController.text,
          ),
          onSubmitSuccess: () {
            showSnackBar(
              context: context,
              snackBar: const SnackBar(
                content: Text('Login successful'),
              ),
            );
          },
        );
      } else {
        final newUser = User.newUser(
          firstName: userFormLogic.firstNameController.text,
          lastName: userFormLogic.lastNameController.text,
          username: userFormLogic.usernameController.text,
          email: userFormLogic.emailController.text,
          password: userFormLogic.passwordController.text,
        );
        authLogic.onRegisterSubmit(
          registerData: newUser,
          onRegisterSuccess: () {
            showSnackBar(
              context: context,
              snackBar: const SnackBar(
                content: Text('User successfully created!'),
              ),
            );
            selectedForm.value = FormType.login;
            userFormLogic.clearAllControllers();
          },
        );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selectedForm.value == FormType.login)
                Text(
                  'SIMPLE IAM',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              const SizedBox(height: 12),
              Text(
                selectedForm.value == FormType.login ? 'LOGIN' : 'REGISTER',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .color!
                          .withValues(
                            alpha: 0.7,
                          ),
                    ),
              ),
              const SizedBox(height: 12),
              if (selectedForm.value == FormType.login)
                LoginForm(userFormLogic: userFormLogic)
              else
                RegisterForm(userFormLogic: userFormLogic),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (authLogic.isLoading) return;
                  onFormSubmit(selectedForm.value);
                },
                child: ButtonChildWithLoading(
                  isLoading: authLogic.isLoading,
                  child: Text(
                    selectedForm.value == FormType.login ? 'Login' : 'Register',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  userFormLogic.clearAllControllers();
                  FocusScope.of(context).unfocus();
                  if (selectedForm.value == FormType.login) {
                    selectedForm.value = FormType.register;
                  } else {
                    selectedForm.value = FormType.login;
                  }
                },
                child: Text(
                  selectedForm.value == FormType.login
                      ? 'Create a new account'
                      : 'I already have an account',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
