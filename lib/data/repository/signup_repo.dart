import 'package:jwt_decode/jwt_decode.dart';
import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/data/dataSource/local/boxes.dart';
import 'package:portfolio_mng_frontend/data/dataSource/remote/api_base.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/helpers/api_error_handler.dart';

class SignupRepo {
  final ApiBase apiBase;
  final Boxes boxes;
  SignupRepo({
    required this.apiBase,
    required this.boxes,
  });

  Future<ApiResponse> signup(SignupModel signupModel) async {
    ApiResponse apiResponse;
    try {
      final responseBody =
          await apiBase.httpPost(ApiUrl.signup, body: signupModel.toJson());
      apiResponse =
          ApiResponse.success(data: null, message: responseBody['message']);
      final token = responseBody['data'];
      // parse token
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      // save user
      final user = User.fromJson(payload);
      user.token = token;

      boxes.saveUser(user);
      boxes.saveLoggedInUserId(user.id);
    } catch (e) {
      apiResponse =
          ApiResponse.error(message: ApiErrorHandler.getErrorMessage(e));
    }
    return apiResponse;
  }
}
