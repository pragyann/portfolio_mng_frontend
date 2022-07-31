import 'package:flutter/cupertino.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/data/repository/repository.dart';
import 'package:portfolio_mng_frontend/helpers/helpers.dart';

class BuySellViewProvider extends ChangeNotifier {
  final StockRepo stockRepo;

  BuySellViewProvider({required this.stockRepo});

  int _selectedIndex = 0;
  List<CompanyStockModel> _companyStocks = [];
  bool _gettingCompanyStocks = false;
  CompanyStockModel? _selectedCompanyStock;
  UserStockModel? _selectedUserStock;

  List<CompanyStockModel> get companyStocks => _companyStocks;
  bool get gettingCompanyStocks => _gettingCompanyStocks;
  CompanyStockModel? get selectedCompanyStock => _selectedCompanyStock;
  int get selectedIndex => _selectedIndex;
  UserStockModel? get selectedUserStock => _selectedUserStock;

  clearSelectedCompanyStock() {
    _selectedCompanyStock = null;
  }

  setSelectedCompanyStock(CompanyStockModel? stock) {
    _selectedCompanyStock = stock;
    notifyListeners();
  }

  clearSelectedUserStock() {
    _selectedUserStock = null;
    notifyListeners();
  }

  setSelectedUserStock(UserStockModel? stock) {
    _selectedUserStock = stock;
    notifyListeners();
  }

  getCompanyStocks() async {
    _gettingCompanyStocks = true;
    final apiResponse = await stockRepo.getCompanyPlaceStock();
    if (apiResponse.status == Status.success) {
      _companyStocks = apiResponse.data!;
      _gettingCompanyStocks = false;
      notifyListeners();
    }
  }

  toggleIndex() {
    if (_selectedIndex == 0) {
      _selectedIndex = 1;
    } else {
      _selectedIndex = 0;
    }
    notifyListeners();
  }
}
