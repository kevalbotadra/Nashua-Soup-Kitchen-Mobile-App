class StatisticException implements Exception{
  final String message;

  StatisticException({this.message = 'Unknown error occurred. '});
}