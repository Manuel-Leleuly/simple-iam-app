import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete,
}

Future<http.Response> sendRequest(
  Uri url, {
  required HttpMethod method,
  String? accessToken,
  Map<String, String>? headers,
  Map<String, dynamic>? reqBody,
  Encoding? encoding,
}) async {
  var httpHeaders = {
    HttpHeaders.contentTypeHeader: ContentType.json.value,
  };

  if (accessToken != null) {
    httpHeaders = {
      ...httpHeaders,
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    };
  }

  if (headers != null) {
    httpHeaders = {...httpHeaders, ...headers};
  }

  final encodedReqBody = json.encode(reqBody);

  switch (method) {
    case HttpMethod.get:
      return await http.get(url, headers: httpHeaders);
    case HttpMethod.post:
      return await http.post(
        url,
        headers: httpHeaders,
        body: encodedReqBody,
        encoding: encoding,
      );
    case HttpMethod.put:
      return await http.put(
        url,
        headers: httpHeaders,
        body: encodedReqBody,
        encoding: encoding,
      );
    case HttpMethod.patch:
      return await http.patch(
        url,
        headers: httpHeaders,
        body: encodedReqBody,
        encoding: encoding,
      );
    case HttpMethod.delete:
      return await http.delete(
        url,
        headers: httpHeaders,
        body: encodedReqBody,
        encoding: encoding,
      );
  }
}
