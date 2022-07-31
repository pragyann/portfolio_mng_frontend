List<UserStockModel> userStockModelList(dynamic json) =>
    List<UserStockModel>.from(
        json.map((data) => UserStockModel.fromJson(data)));

class UserStockModel {
  UserStockModel({
    required this.userId,
    required this.stockId,
    required this.quantity,
    required this.usableQty,
    required this.name,
    required this.acr,
    required this.initialPpu,
    required this.currentPpu,
    required this.totalInv,
    required this.soldAmt,
    required this.profit,
  });

  final int userId;
  final int stockId;
  final int quantity;
  final int usableQty;
  final String name;
  final String acr;
  final int initialPpu;
  final int currentPpu;
  final int totalInv;
  final int soldAmt;
  final int profit;

  factory UserStockModel.fromJson(Map<String, dynamic> json) => UserStockModel(
        userId: json["user_id"],
        stockId: json["stock_id"],
        quantity: json["quantity"],
        usableQty: json["usable_qty"],
        name: json["name"],
        acr: json["acr"],
        initialPpu: json["initial_ppu"],
        currentPpu: json["current_ppu"],
        totalInv: json["total_inv"],
        soldAmt: json["sold_amt"],
        profit: json["profit"],
      );
}
