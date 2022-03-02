class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({required this.message});
}