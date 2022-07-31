class ApiUrl {
  static const baseUrl = 'http://192.168.10.71:3000/';

  static const login = 'login';
  static const signup = 'signup';
  static const getMarketStock = 'stock/market_stock';
  static const getCompanyStock = 'stock/company_stock';
  static const getUserStock = 'stock/user_stock';
  static const getUserTransactions = 'transaction/user_transactions';
  static const buyFromCompany = 'transaction/buy_from_company';
  static const buyFromMarket = 'transaction/buy_from_market';
  static const addToMarket = 'transaction/add_to_market';
  static const getUserMarketStock = 'stock/user_market_stock';
}
