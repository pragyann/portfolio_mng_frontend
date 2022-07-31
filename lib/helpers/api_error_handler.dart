import 'dart:async';
import 'dart:io';
import 'package:portfolio_mng_frontend/data/dataSource/remote/app_exception.dart';

class ApiErrorHandler {
  static String getErrorMessage(error) {
    String errorMessage = '';
    if (error is AppException) {
      errorMessage = error.toString();
    } else if (error is SocketException) {
      errorMessage = 'No internet connection. Please try again.';
    } else if (error is TimeoutException) {
      errorMessage = 'Connection timed out. Please try again later.';
    } else {
      errorMessage = 'An error occured.';
    }
    return errorMessage;
  }
}
