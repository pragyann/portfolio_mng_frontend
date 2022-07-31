import 'package:hive/hive.dart';
import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';

class Boxes {
  Box<User> get userBox => Hive.box<User>('user');
  Box get normalBox => Hive.box('normalbox');

  // Only some methods used in multiple places are defined here.

  // user
  void saveUser(User user) async {
    await userBox.put(user.id, user);
  }

  User? getUser(String key) {
    return userBox.get(key);
  }

  // logged in user
  User? getLoggedInUser() {
    return userBox.get(normalBox.get(DBConstants.loggedInUserId));
  }

  Future<void> removeLoggedInUser() async {
    await userBox.delete(normalBox.get(DBConstants.loggedInUserId));
  }

  // logged in userId
  String getLoggedInUserId() {
    String loggedInUserId = normalBox.get(DBConstants.loggedInUserId) ?? "";
    return loggedInUserId;
  }

  Future saveLoggedInUserId(String id) async {
    await normalBox.put(DBConstants.loggedInUserId, id);
  }

  Future removeLoggedInUserId() async {
    await normalBox.delete(DBConstants.loggedInUserId);
  }
}
