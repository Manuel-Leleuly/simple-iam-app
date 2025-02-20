import 'package:simple_iam/constants/regex.dart';

class AuthValidator {
  const AuthValidator();

  String? validateFirstName(String? firstName) {
    if (isEmpty(firstName)) {
      return 'First Name is required';
    }

    if (!nameRegex.hasMatch(firstName!)) {
      return 'First Name only allows alphabets';
    }

    if (firstName.length < 2) {
      return 'First Name must have a minimum of 2 characters';
    }

    if (firstName.length > 15) {
      return 'First Name must not exceed 15 characters';
    }

    return null;
  }

  String? validateLastName(String? lastName) {
    if (!isEmpty(lastName)) {
      if (!nameRegex.hasMatch(lastName!)) {
        return 'Last Name only allows alphabets';
      }

      if (lastName.length < 2) {
        return 'Last Name must have a minimum of 2 characters';
      }

      if (lastName.length > 15) {
        return 'Last Name must not exceed 15 characters';
      }
    }

    return null;
  }

  String? validateUsername(String? username) {
    if (isEmpty(username)) {
      return 'Username is required';
    }

    if (!usernameRegex.hasMatch(username!)) {
      return 'Username must be alphanumeric';
    }

    if (username.length < 5) {
      return 'Username must have a minimum of 5 characters';
    }

    return null;
  }

  String? validateEmail(String? email) {
    if (isEmpty(email)) return 'email is required';

    if (!emailRegex.hasMatch(email!)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? validatePassword(String? password, {bool isLogin = false}) {
    if (isEmpty(password)) {
      return 'Password is required';
    }

    if (isLogin) return null;

    if (password!.length < 8) {
      return 'Password must have a minimum of 8 characters';
    }

    return null;
  }
}

// helper methods
bool isEmpty(String? value) {
  return value == null || value.isEmpty;
}
