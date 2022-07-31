List<UserMarketStockModel> userMarketStockModelList(dynamic json) =>
    List<UserMarketStockModel>.from(
        json.map((data) => UserMarketStockModel.fromJson(data)));

class UserMarketStockModel {
  UserMarketStockModel({
    required this.saleId,
    required this.userId,
    required this.stockId,
    required this.quantity,
    required this.ppu,
    required this.name,
    required this.initialPpu,
    required this.currentPpu,
    required this.acr,
  });

  final int saleId;
  final int userId;
  final int stockId;
  final int quantity;
  final int ppu;
  final String name;
  final int initialPpu;
  final int currentPpu;
  final String acr;

  factory UserMarketStockModel.fromJson(Map<String, dynamic> json) =>
      UserMarketStockModel(
        saleId: json["sale_id"],
        userId: json["user_id"],
        stockId: json["stock_id"],
        quantity: json["quantity"],
        ppu: json["ppu"],
        name: json["name"],
        initialPpu: json["initial_ppu"],
        currentPpu: json["current_ppu"],
        acr: json["acr"],
      );
}
