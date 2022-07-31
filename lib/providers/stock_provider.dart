// import 'package:flutter/cupertino.dart';
// import 'package:portfolio_mng_frontend/data/models/models.dart';
// import 'package:portfolio_mng_frontend/data/repository/repository.dart';
// import 'package:portfolio_mng_frontend/helpers/helpers.dart';

// class StockProvider extends ChangeNotifier {
//   final StockRepo stockRepo;

//   StockProvider({required this.stockRepo});

//   List<CompanyStockModel> _companyStocks = [];
//   List<UserStockModel> _userStocks = [];
//   bool _gettingCompanyStocks = false;
//   bool _gettingUserStocks = false;
//   CompanyStockModel? _selectedCompanyStock;

//   List<CompanyStockModel> get companyStocks => _companyStocks;
//   List<UserStockModel> get userStocks => _userStocks;
//   bool get gettingCompanyStocks => _gettingCompanyStocks;
//   bool get gettingUserStocks => _gettingUserStocks;
//   CompanyStockModel? get selectedCompanyStock => _selectedCompanyStock;

//   initStocks() {
//     getCompanyStocks();
//     getUserStocks();
//   }

//   clearSelectedCompanyStock() {
//     _selectedCompanyStock = null;
//   }

//   setSelectedCompanyStock(CompanyStockModel? stock) {
//     _selectedCompanyStock = stock;
//     notifyListeners();
//   }

//   getCompanyStocks() async {
//     _gettingCompanyStocks = true;
//     final apiResponse = await stockRepo.getCompanyPlaceStock();
//     if (apiResponse.status == Status.success) {
//       _companyStocks = apiResponse.data!;
//       _gettingCompanyStocks = false;
//       notifyListeners();
//     }
//   }

//   getUserStocks() async {
//     _gettingUserStocks = true;
//     final apiResponse = await stockRepo.getUserStock();
//     if (apiResponse.status == Status.success) {
//       _userStocks = apiResponse.data!;
//       _gettingUserStocks = false;
//       notifyListeners();
//     }
//   }
// }
