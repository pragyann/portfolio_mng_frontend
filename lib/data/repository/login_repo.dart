import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/data/dataSource/local/boxes.dart';
import 'package:portfolio_mng_frontend/data/dataSource/remote/api_base.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/helpers/helpers.dart';

class LoginRepo {
  final ApiBase apiBase;
  final Boxes boxes;

  LoginRepo({required this.apiBase, required this.boxes});

  Future<ApiResponse> login(LoginModel loginModel) async {
    ApiResponse apiResponse;
    try {
      final responseBody =
          await apiBase.httpPost(ApiUrl.login, body: loginModel.toJson());
      apiResponse =
          ApiResponse.success(data: null, message: responseBody['message']);
      // save user
      final user = User.fromJson(responseBody['data']);
      boxes.saveUser(user);
      boxes.saveLoggedInUserId(user.id);
    } catch (e) {
      apiResponse =
          ApiResponse.error(message: ApiErrorHandler.getErrorMessage(e));
    }
    return apiResponse;
  }

  Future<ApiResponse> logout() async {
    ApiResponse apiResponse;
    try {
      await boxes.removeLoggedInUser();
      await boxes.removeLoggedInUserId();
      apiResponse =
          ApiResponse.success(data: null, message: 'Logout successful');
    } catch (e) {
      apiResponse =
          ApiResponse.error(message: ApiErrorHandler.getErrorMessage(e));
    }
    return apiResponse;
  }
}
