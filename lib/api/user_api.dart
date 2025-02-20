import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:simple_iam/helpers/uri_helper.dart';
import 'package:simple_iam/models/response_model.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/models/user_params_model.dart';

class UserApi {
  const UserApi();

  Future<User?> createUser(UserCreateReqBody reqBody) async {
    try {
      final uri = getUri(path: '/iam/v1/users');
      final response = await http.post(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
        body: json.encode(reqBody.toJson()),
      );

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = json.decode(response.body);
        return User.fromJson(responseBody['data']);
      }

      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<User?> getUserById(String id) async {
    try {
      final uri = getUri(path: '/iam/v1/users/$id');
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = json.decode(response.body);
        return User.fromJson(responseBody['data']);
      }

      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<WithPagination<List<User>>?> getUserList(UserListParams params) async {
    try {
      final uri = getUri(
        path: '/iam/v1/users',
        queryParams: params.toJson(),
      );
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = json.decode(response.body)['data'];
        return WithPagination<List<User>>(
          data: getUserListFromJsonResponse(responseBody['data']),
          paging: Paging.fromJson(responseBody['paging']),
        );
      }

      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
