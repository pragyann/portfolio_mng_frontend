class AppException implements Exception {
  final String _message;
  final int _statusCode;

  AppException(this._message, this._statusCode);

  int get statusCode => _statusCode;

  @override
  String toString() {
    return _message;
  }
}
