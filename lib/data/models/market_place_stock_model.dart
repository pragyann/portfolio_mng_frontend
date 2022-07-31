List<MarketPlaceStockModel> marketPlaceStockModelList(dynamic json) =>
    List<MarketPlaceStockModel>.from(
        json.map((data) => MarketPlaceStockModel.fromJson(data)));

class MarketPlaceStockModel {
  MarketPlaceStockModel({
    required this.saleId,
    required this.userId,
    required this.stockId,
    required this.quantity,
    required this.ppu,
    required this.name,
    required this.acr,
    required this.currentPpu,
  });

  final int saleId;
  final int userId;
  final int stockId;
  final int quantity;
  final int ppu;
  final String name;
  final String acr;
  final int currentPpu;

  factory MarketPlaceStockModel.fromJson(Map<String, dynamic> json) =>
      MarketPlaceStockModel(
        saleId: json["sale_id"],
        userId: json["user_id"],
        stockId: json["stock_id"],
        quantity: json["quantity"],
        ppu: json["ppu"],
        name: json["name"],
        acr: json["acr"],
        currentPpu: json["current_ppu"],
      );
}
