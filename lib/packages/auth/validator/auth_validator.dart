import 'package:simple_iam/constants/regex.dart';

class AuthValidator {
  const AuthValidator();

  String? validateEmail(String? email) {
    final isEmailEmpty = email == null || email.isEmpty;
    if (isEmailEmpty) return 'email is required';

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? validatePassword(String? password, {bool isLogin = false}) {
    final isPasswordEmpty = password == null || password.isEmpty;

    if (isPasswordEmpty) {
      return 'Password is required';
    }

    if (isLogin) return null;

    // TODO: create validation for register

    return null;
  }
}
