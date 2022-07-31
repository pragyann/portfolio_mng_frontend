import 'package:portfolio_mng_frontend/constants/api_url.dart';
import 'package:portfolio_mng_frontend/data/dataSource/remote/api_base.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/helpers/api_error_handler.dart';

class StockRepo {
  final ApiBase apiBase;

  StockRepo({required this.apiBase});

  Future<ApiResponse<List<MarketPlaceStockModel>>> getMarketPlaceStock() async {
    ApiResponse<List<MarketPlaceStockModel>> apiResponse;
    try {
      final responseBody = await apiBase.httpGet(ApiUrl.getMarketStock);
      apiResponse = ApiResponse.success(
        data: marketPlaceStockModelList(
          responseBody['data'],
        ),
      );
    } catch (e) {
      apiResponse =
          ApiResponse.error(message: ApiErrorHandler.getErrorMessage(e));
    }
    return apiResponse;
  }

  Future<ApiResponse<List<CompanyStockModel>>> getCompanyPlaceStock() async {
    ApiResponse<List<CompanyStockModel>> apiResponse;
    try {
      final responseBody = await apiBase.httpGet(ApiUrl.getCompanyStock);
      apiResponse = ApiResponse.success(
        data: companyStockModelList(
          responseBody['data'],
        ),
      );
    } catch (e) {
      apiResponse =
          ApiResponse.error(message: ApiErrorHandler.getErrorMessage(e));
    }
    return apiResponse;
  }

  Future<ApiResponse<List<UserStockModel>>> getUserStock() async {
    ApiResponse<List<UserStockModel>> apiResponse;
    try {
      final responseBody = await apiBase.httpGet(ApiUrl.getUserStock);
      apiResponse = ApiResponse.success(
        data: userStockModelList(
          responseBody['data'],
        ),
      );
    } catch (e) {
      apiResponse =
          ApiResponse.error(message: ApiErrorHandler.getErrorMessage(e));
    }
    return apiResponse;
  }

  Future<ApiResponse<List<UserMarketStockModel>>> getUserMarketStock() async {
    ApiResponse<List<UserMarketStockModel>> apiResponse;
    try {
      final responseBody = await apiBase.httpGet(ApiUrl.getUserMarketStock);
      apiResponse = ApiResponse.success(
        data: userMarketStockModelList(
          responseBody['data'],
        ),
      );
    } catch (e) {
      apiResponse =
          ApiResponse.error(message: ApiErrorHandler.getErrorMessage(e));
    }
    return apiResponse;
  }

  Future<ApiResponse> removeFromMarket(String stockId) async {
    ApiResponse apiResponse;
    try {
      final responseBody = await apiBase
          .httpPost(ApiUrl.removeFromMarket, body: {'stock_id': stockId});
      apiResponse =
          ApiResponse.success(data: null, message: responseBody['message']);
    } catch (e) {
      apiResponse =
          ApiResponse.error(message: ApiErrorHandler.getErrorMessage(e));
    }
    return apiResponse;
  }
}
