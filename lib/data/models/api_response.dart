import 'package:portfolio_mng_frontend/helpers/helpers.dart';

class ApiResponse<T> {
  T? data;
  String message;
  Status status;

  ApiResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  ApiResponse.success({
    required this.data,
    this.status = Status.success,
    this.message = '',
  });

  ApiResponse.error({
    this.status = Status.error,
    required this.message,
  });
}
