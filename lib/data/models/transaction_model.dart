List<TransactionModel> transactionModelList(dynamic json) =>
    List<TransactionModel>.from(
        json.map((data) => TransactionModel.fromJson(data)));

class TransactionModel {
  TransactionModel({
    required this.tId,
    required this.userId,
    required this.stockId,
    required this.quantity,
    required this.ppu,
    required this.transacDate,
    required this.transacType,
    required this.name,
    required this.initialPpu,
    required this.currentPpu,
    required this.acr,
  });

  final int tId;
  final int userId;
  final int stockId;
  final int quantity;
  final int ppu;
  final DateTime transacDate;
  final String transacType;
  final String name;
  final int initialPpu;
  final int currentPpu;
  final String acr;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        tId: json["t_id"],
        userId: json["user_id"],
        stockId: json["stock_id"],
        quantity: json["quantity"],
        ppu: json["ppu"],
        transacDate: DateTime.parse(json["transac_date"]),
        transacType: json["transac_type"],
        name: json["name"],
        initialPpu: json["initial_ppu"],
        currentPpu: json["current_ppu"],
        acr: json["acr"],
      );

  Map<String, dynamic> toJson() => {
        "t_id": tId,
        "user_id": userId,
        "stock_id": stockId,
        "quantity": quantity,
        "ppu": ppu,
        "transac_date": transacDate.toIso8601String(),
        "transac_type": transacType,
        "name": name,
        "initial_ppu": initialPpu,
        "current_ppu": currentPpu,
      };
}
