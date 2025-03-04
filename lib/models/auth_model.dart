class Login {
  final String email;
  final String password;

  const Login({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class Token {
  final String accessToken;
  final String refreshToken;

  const Token({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Token.init() {
    return const Token(
      accessToken: '',
      refreshToken: '',
    );
  }

  factory Token.fromJson(Map<String, dynamic> jsonData) {
    return Token(
      accessToken: jsonData['access_token'],
      refreshToken: jsonData['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
}
