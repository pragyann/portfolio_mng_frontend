import 'package:flutter/cupertino.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/data/repository/repository.dart';
import 'package:portfolio_mng_frontend/helpers/helpers.dart';

class SignupProvider extends ChangeNotifier {
  final SignupRepo signupRepo;

  SignupProvider({required this.signupRepo});

  bool _signingUp = false;

  bool get signingUp => _signingUp;

  signup(
    String email,
    String password,
    String fullName,
    String phone,
    Function(bool, String) callback,
  ) async {
    _signingUp = true;
    notifyListeners();
    final signupModel = SignupModel(
      fullName: fullName,
      password: password,
      phone: phone,
      email: email,
    );
    final apiResponse = await signupRepo.signup(signupModel);
    callback(apiResponse.status == Status.success, apiResponse.message);
    _signingUp = false;
    notifyListeners();
  }
}
