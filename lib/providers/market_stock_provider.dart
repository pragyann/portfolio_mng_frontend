import 'package:flutter/cupertino.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/data/repository/repository.dart';
import 'package:portfolio_mng_frontend/helpers/helpers.dart';

class MarketStockProvider extends ChangeNotifier {
  final StockRepo stockRepo;
  MarketStockProvider({required this.stockRepo});

  List<MarketPlaceStockModel> _marketPlaceStocks = [];
  bool _gettingMarketStocks = false;
  int _slideIndex = 0;

  int get slideIndex => _slideIndex;
  List<MarketPlaceStockModel> get marketPlaceStocks => _marketPlaceStocks;
  bool get gettingMarketStocks => _gettingMarketStocks;

  setSlideIndex(int value) {
    _slideIndex = value;
    notifyListeners();
  }

  getMarketPlaceStocks() async {
    _gettingMarketStocks = true;
    final apiResponse = await stockRepo.getMarketPlaceStock();
    if (apiResponse.status == Status.success) {
      _marketPlaceStocks = apiResponse.data!;
    }
    _gettingMarketStocks = false;
    notifyListeners();
  }

  clear() {
    _marketPlaceStocks = [];
  }
}
