import 'package:flutter/cupertino.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/data/repository/repository.dart';
import 'package:portfolio_mng_frontend/helpers/helpers.dart';

class LoginProvider extends ChangeNotifier {
  final LoginRepo loginRepo;

  LoginProvider({required this.loginRepo});
  bool _loggingin = false;
  bool _loggingout = false;

  bool get logginin => _loggingin;
  bool get loggingout => _loggingout;

  login(String email, String password, Function(bool, String) callback) async {
    _loggingin = true;
    notifyListeners();

    final loginModel = LoginModel(
      email: email,
      password: password,
    );
    final apiResponse = await loginRepo.login(loginModel);
    _loggingin = false;
    notifyListeners();
    callback(apiResponse.status == Status.success, apiResponse.message);
  }

  logout(Function(bool, String) callback) async {
    _loggingout = true;
    notifyListeners();
    final apiResponse = await loginRepo.logout();
    callback(apiResponse.status == Status.success, apiResponse.message);
    _loggingout = false;
    notifyListeners();
  }
}
