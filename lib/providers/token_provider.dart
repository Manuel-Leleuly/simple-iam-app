import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_iam/models/auth_model.dart';

part 'token_provider.g.dart';

@riverpod
class TokenNotifier extends _$TokenNotifier {
  @override
  Token build() {
    return Token.init();
  }

  set token(Token newTokens) {
    state = newTokens;
  }

  void clearTokens() {
    state = Token.init();
  }
}
