class BuyFromMarketModel {
  String saleId;
  String quantity;

  BuyFromMarketModel({required this.saleId, required this.quantity});

  Map<String, String> toJson() {
    return {
      'sale_id': saleId,
      'quantity': quantity,
    };
  }
}
