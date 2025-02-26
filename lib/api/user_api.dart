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
      if (response.statusCode != HttpStatus.ok) return null;

      final responseBody = json.decode(response.body);
      return User.fromJson(responseBody['data']);
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
      if (response.statusCode != HttpStatus.ok) return null;

      final responseBody = json.decode(response.body);
      return User.fromJson(responseBody['data']);
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
      if (response.statusCode != HttpStatus.ok) return null;

      final responseBody = json.decode(response.body);
      return WithPagination<List<User>>(
        data: getUserListFromJsonResponse(responseBody['data']),
        paging: Paging.fromJson(responseBody['paging']),
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<Response<String>?> removeUser(String userId) async {
    try {
      final uri = getUri(path: '/iam/v1/users/$userId');
      final response = await sendRequest(
        uri,
        method: HttpMethod.delete,
        accessToken: _accessToken,
      );
      if (response.statusCode != HttpStatus.ok) return null;

      final responseBody = json.decode(response.body);
      return Response<String>(data: responseBody['data']);
    } catch (error) {
      print(error);
      return null;
    }
  }
}
