class Token {
  final String token;

  Token({required this.token});

  factory Token.fromJSON(Map<String, dynamic> json) {
    return Token(token: json["token"]);
  }

}
