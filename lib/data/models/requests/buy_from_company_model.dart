class BuyFromCompanyModel {
  String stockId;
  String quantity;

  BuyFromCompanyModel({required this.stockId, required this.quantity});

  Map<String, String> toJson() {
    return {
      'stock_id': stockId,
      'quantity': quantity,
    };
  }
}
