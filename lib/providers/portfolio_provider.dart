import 'package:flutter/cupertino.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/data/repository/repository.dart';
import 'package:portfolio_mng_frontend/helpers/helpers.dart';

class PortfolioProvider extends ChangeNotifier {
  final StockRepo stockRepo;

  PortfolioProvider({required this.stockRepo});

  List<UserStockModel> _userStocks = [];
  List<UserMarketStockModel> _userMarketStocks = [];
  bool _gettingUserStocks = false;
  bool _gettingUserMarketStocks = false;

  List<UserStockModel> get userStocks => _userStocks;
  bool get gettingUserStocks => _gettingUserStocks;
  List<UserMarketStockModel> get userMarketStocks => _userMarketStocks;
  bool get gettingUserMarketStocks => _gettingUserMarketStocks;

  getUserStocks() async {
    if (_userStocks.isEmpty) {
      _gettingUserStocks = true;
    }
    final apiResponse = await stockRepo.getUserStock();
    if (apiResponse.status == Status.success) {
      _userStocks = apiResponse.data!;
    }
    _gettingUserStocks = false;
    notifyListeners();
  }

  getUserMarketStocks() async {
    if (_userMarketStocks.isEmpty) {
      _gettingUserMarketStocks = true;
    }
    final apiResponse = await stockRepo.getUserMarketStock();
    if (apiResponse.status == Status.success) {
      _userMarketStocks = apiResponse.data!;
    }
    _gettingUserMarketStocks = false;
    notifyListeners();
  }

  removeStockFromMarket(String stockId, Function(bool, String) callback) async {
    final apiResponse = await stockRepo.removeFromMarket(stockId);
    if (apiResponse.status == Status.success) {
      await Future.wait(<Future>[
        getUserMarketStocks(),
        getUserStocks(),
      ]);
      callback(true, apiResponse.message);
    } else {
      callback(false, apiResponse.message);
    }
  }

  clear() {
    _userStocks = [];
    _userMarketStocks = [];
  }
}
