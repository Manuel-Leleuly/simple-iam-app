import 'package:simple_iam/constants/env.dart';

Uri getUri({required String path, Map<String, dynamic>? queryParams}) {
  final baseUri = Uri.parse(Env.baseUrl);

  return Uri(
    scheme: baseUri.scheme,
    host: baseUri.host,
    port: baseUri.port,
    path: path,
    queryParameters: queryParams,
  );
}
