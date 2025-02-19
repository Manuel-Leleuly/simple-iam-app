import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_iam/models/auth_model.dart';

class TokenNotifier extends StateNotifier<Token> {
  TokenNotifier()
      : super(const Token(
          accessToken: '',
          refreshToken: '',
        ));

  void setToken(Token newTokens) {
    state = newTokens;
  }

  void clearTokens() {
    state = const Token(
      accessToken: '',
      refreshToken: '',
    );
  }
}

final tokenProvider =
    StateNotifierProvider<TokenNotifier, Token>((ref) => TokenNotifier());
