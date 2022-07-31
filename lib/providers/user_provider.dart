import 'package:flutter/cupertino.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/data/repository/repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepo userRepo;

  UserProvider({
    required this.userRepo,
  });

  bool get isLoggedIn => userRepo.isLoggedIn();
  User get user => userRepo.getLoggedInUser();
}
