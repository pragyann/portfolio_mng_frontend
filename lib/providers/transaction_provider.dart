import 'package:flutter/cupertino.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/data/models/transaction_model.dart';
import 'package:portfolio_mng_frontend/data/repository/repository.dart';
import 'package:portfolio_mng_frontend/helpers/helpers.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepo transactionRepo;

  TransactionProvider({required this.transactionRepo});

  List<TransactionModel> _userTransactions = [];
  bool _gettinUserTransacs = false;

  List<TransactionModel> get userTransactions => _userTransactions;
  bool get gettingUserTransacs => _gettinUserTransacs;

  getUserTransactions() async {
    if (_userTransactions.isEmpty) {
      _gettinUserTransacs = true;
    }
    final apiResponse = await transactionRepo.getUserTransactions();
    if (apiResponse.status == Status.success) {
      _userTransactions = apiResponse.data!;
    }
    _gettinUserTransacs = false;
    notifyListeners();
  }

  clear() {
    _userTransactions = [];
  }

  buyFromCompany(
    String stockId,
    String quantity,
    Function(bool, String) callback,
  ) async {
    final buyFromCompanyModel = BuyFromCompanyModel(
      stockId: stockId,
      quantity: quantity,
    );
    final apiResponse =
        await transactionRepo.buyFromCompany(buyFromCompanyModel);
    callback(apiResponse.status == Status.success, apiResponse.message);
  }

  addToMarket(
    String stockId,
    String quantity,
    String ppu,
    Function(bool, String) callback,
  ) async {
    final addToMarketPlaceModel = AddToMarketPlaceModel(
      stockId: stockId,
      quantity: quantity,
      ppu: ppu,
    );
    final apiResponse =
        await transactionRepo.addToMarket(addToMarketPlaceModel);
    callback(apiResponse.status == Status.success, apiResponse.message);
  }

  buyFromMarket(
    String saleId,
    String quantity,
    Function(bool, String) callback,
  ) async {
    final buyFromMarketModel = BuyFromMarketModel(
      saleId: saleId,
      quantity: quantity,
    );
    final apiResponse = await transactionRepo.buyFromMarket(buyFromMarketModel);
    callback(apiResponse.status == Status.success, apiResponse.message);
  }
}
