import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:simple_iam/helpers/uri_helper.dart';
import 'package:simple_iam/models/auth_model.dart';

class AuthApi {
  const AuthApi();

  Future<Token?> login(Login loginData) async {
    try {
      final uri = getUri(path: '/iam/v1/login');
      final response = await http.post(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
        body: json.encode(loginData.toJson()),
      );

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = json.decode(response.body);
        return Token.fromJson(responseBody['data']);
      }

      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
