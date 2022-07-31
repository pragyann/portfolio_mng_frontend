import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/data/dataSource/local/boxes.dart';
import 'package:portfolio_mng_frontend/data/dataSource/remote/app_exception.dart';

class ApiBase {
  final Boxes boxes;

  ApiBase({required this.boxes});

  Future<dynamic> httpGet(
    String url, {
    Map<String, String>? headers,
  }) async {
    var token = boxes.getLoggedInUser()?.token ?? "";
    try {
      var response = await http.get(Uri.parse(ApiUrl.baseUrl + url),
          headers: {'Authorization': token});
      return _returnResponse(response);
    } catch (e) {
      debugPrint('Error from apiBase httpGet ===> ${e.toString()}');
      rethrow;
    }
  }

  Future<dynamic> httpPost(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    var token = boxes.getLoggedInUser()?.token ?? "";

    try {
      var response = await http.post(Uri.parse(ApiUrl.baseUrl + url),
          headers: {'Authorization': token, 'Accept': 'application/json'},
          body: body);
      return _returnResponse(response);
    } catch (e) {
      debugPrint('Error from apiBase httpPost ===> ${e.toString()}');
      rethrow;
    }
  }

  Future<dynamic> httpMultipartRequest(
    String url, {
    String method = 'POST',
    List<File>? files,
    List<String>? filesFieldnames,
    Map<String, String>? body,
  }) async {
    final request =
        http.MultipartRequest(method, Uri.parse(ApiUrl.baseUrl + url));
    var token = boxes.getLoggedInUser()?.token ?? "";

    var headers = {'Authorization': token, 'Accept': 'application/json'};
    request.headers.addAll(headers);
    if (body != null) {
      request.fields.addAll(body);
    }
    if (files != null && filesFieldnames != null) {
      for (int i = 0; i < files.length; i++) {
        request.files.add(http.MultipartFile(filesFieldnames[i],
            files[i].readAsBytes().asStream(), files[i].lengthSync(),
            filename: files[i].path.split('/').last));
      }
    }
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _returnResponse(response);
    } catch (e) {
      debugPrint(
          'Error from apiBase httpMultipartRequest ===> ${e.toString()}');
      rethrow;
    }
  }

  dynamic _returnResponse(http.Response response) {
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      return responseBody;
    } else {
      if (responseBody['message'] is List &&
          responseBody['message'].length != 0) {
        throw AppException(responseBody['message'][0], response.statusCode);
      } else if (responseBody['message'] is String) {
        throw AppException(responseBody['message'], response.statusCode);
      } else {
        throw AppException('Unhandled App Error.', response.statusCode);
      }
    }
  }
}
