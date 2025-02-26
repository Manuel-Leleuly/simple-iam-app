import 'dart:convert';
import 'dart:io';

import 'package:simple_iam/helpers/api_helper.dart';
import 'package:simple_iam/helpers/uri_helper.dart';
import 'package:simple_iam/models/auth_model.dart';

class AuthApi {
  const AuthApi();

  Future<Token?> login(Login loginData) async {
    try {
      final uri = getUri(path: '/iam/v1/login');
      final response = await sendRequest(
        uri,
        method: HttpMethod.post,
        reqBody: loginData.toJson(),
      );
      if (response.statusCode != HttpStatus.ok) return null;

      final responseBody = json.decode(response.body);
      return Token.fromJson(responseBody['data']);
    } catch (error) {
      print(error);
      return null;
    }
  }
}
