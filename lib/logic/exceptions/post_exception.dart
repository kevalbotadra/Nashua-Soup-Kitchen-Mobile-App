class PostException implements Exception{
  final String message;

  PostException({this.message = 'Unknown error occurred. '});
}