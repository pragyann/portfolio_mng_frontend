import 'package:get_it/get_it.dart';
import 'package:portfolio_mng_frontend/data/dataSource/local/boxes.dart';
import 'package:portfolio_mng_frontend/data/dataSource/remote/api_base.dart';
import 'package:portfolio_mng_frontend/data/repository/repository.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';

final locator = GetIt.I;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => Boxes());
  locator.registerLazySingleton(() => ApiBase(boxes: locator()));

  // repos
  locator.registerLazySingleton(
      () => LoginRepo(apiBase: locator(), boxes: locator()));
  locator.registerLazySingleton(
      () => SignupRepo(apiBase: locator(), boxes: locator()));
  locator.registerLazySingleton(
      () => UserRepo(apiBase: locator(), boxes: locator()));
  locator.registerLazySingleton(() => StockRepo(apiBase: locator()));
  locator.registerLazySingleton(() => TransactionRepo(apiBase: locator()));

  // providers
  locator.registerLazySingleton(() => LoginProvider(loginRepo: locator()));
  locator.registerLazySingleton(() => SignupProvider(signupRepo: locator()));
  locator.registerLazySingleton(() => UserProvider(userRepo: locator()));
  locator.registerLazySingleton(() => MainScreenProvider());
  locator
      .registerLazySingleton(() => MarketStockProvider(stockRepo: locator()));
  locator.registerLazySingleton(
      () => TransactionProvider(transactionRepo: locator()));
  locator.registerLazySingleton(() => PortfolioProvider(stockRepo: locator()));
  locator
      .registerLazySingleton(() => BuySellViewProvider(stockRepo: locator()));
}
