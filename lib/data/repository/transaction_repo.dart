import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/data/dataSource/remote/api_base.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/helpers/api_error_handler.dart';

class TransactionRepo {
  final ApiBase apiBase;

  TransactionRepo({required this.apiBase});

  Future<ApiResponse<List<TransactionModel>>> getUserTransactions() async {
    ApiResponse<List<TransactionModel>> apiResponse;
    try {
      final responseBody = await apiBase.httpGet(ApiUrl.getUserTransactions);
      apiResponse = ApiResponse.success(
        data: transactionModelList(
          responseBody['data'],
        ),
      );
    } catch (e) {
      apiResponse =
          ApiResponse.error(message: ApiErrorHandler.getErrorMessage(e));
    }
    return apiResponse;
  }

  Future<ApiResponse> buyFromCompany(
      BuyFromCompanyModel buyFromCompanyModel) async {
    ApiResponse apiResponse;
    try {
      final responseBody = await apiBase.httpPost(ApiUrl.buyFromCompany,
          body: buyFromCompanyModel.toJson());

      apiResponse =
          ApiResponse.success(data: null, message: responseBody['message']);
    } catch (e) {
      apiResponse =
          ApiResponse.error(message: ApiErrorHandler.getErrorMessage(e));
    }
    return apiResponse;
  }

  Future<ApiResponse> addToMarket(
      AddToMarketPlaceModel addToMarketPlaceModel) async {
    ApiResponse apiResponse;
    try {
      final responseBody = await apiBase.httpPost(
        ApiUrl.addToMarket,
        body: addToMarketPlaceModel.toJson(),
      );
      apiResponse =
          ApiResponse.success(data: null, message: responseBody['message']);
    } catch (e) {
      apiResponse =
          ApiResponse.error(message: ApiErrorHandler.getErrorMessage(e));
    }
    return apiResponse;
  }

  Future<ApiResponse> buyFromMarket(
      BuyFromMarketModel buyFromMarketModel) async {
    ApiResponse apiResponse;
    try {
      final responseBody = await apiBase.httpPost(ApiUrl.buyFromMarket,
          body: buyFromMarketModel.toJson());

      apiResponse =
          ApiResponse.success(data: null, message: responseBody['message']);
    } catch (e) {
      apiResponse =
          ApiResponse.error(message: ApiErrorHandler.getErrorMessage(e));
    }
    return apiResponse;
  }
}
