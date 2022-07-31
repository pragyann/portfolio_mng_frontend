import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/data/dataSource/local/boxes.dart';
import 'package:portfolio_mng_frontend/data/dataSource/remote/api_base.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';

class UserRepo {
  final ApiBase apiBase;
  final Boxes boxes;

  UserRepo({required this.apiBase, required this.boxes});

  bool isLoggedIn() {
    return boxes.normalBox.containsKey(DBConstants.loggedInUserId);
  }

  User getLoggedInUser() {
    return boxes.getLoggedInUser()!;
  }
}
