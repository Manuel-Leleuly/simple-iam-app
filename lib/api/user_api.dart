import 'dart:convert';
import 'dart:io';

import 'package:simple_iam/helpers/api_helper.dart';
import 'package:simple_iam/helpers/uri_helper.dart';
import 'package:simple_iam/models/response_model.dart';
import 'package:simple_iam/models/user_model.dart';
import 'package:simple_iam/models/user_params_model.dart';

class UserApi {
  final String? _accessToken;

  // TODO: find a way to make api helper get access token directly
  const UserApi([this._accessToken]);

  Future<User?> createUser(UserCreateReqBody reqBody) async {
    try {
      final uri = getUri(path: '/iam/v1/users');
      final response = await sendRequest(
        uri,
        method: HttpMethod.post,
        reqBody: reqBody.toJson(),
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
      final response = await sendRequest(
        uri,
        accessToken: _accessToken,
        method: HttpMethod.get,
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

  Future<WithPagination<List<User>>?> getUserList(
      [UserListParams? params]) async {
    try {
      final uri = getUri(
        path: '/iam/v1/users',
        queryParams: params?.toJson(),
      );
      final response = await sendRequest(
        uri,
        method: HttpMethod.get,
        accessToken: _accessToken,
      );

      print({'status code': response.statusCode});

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = json.decode(response.body);
        print({'response body': responseBody});
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
