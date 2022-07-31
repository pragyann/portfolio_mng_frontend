List<CompanyStockModel> companyStockModelList(dynamic json) =>
    List<CompanyStockModel>.from(
        json.map((data) => CompanyStockModel.fromJson(data)));

class CompanyStockModel {
  CompanyStockModel({
    required this.id,
    required this.name,
    required this.initialPpu,
    required this.currentPpu,
    required this.quantity,
    required this.acr,
  });

  final int id;
  final String name;
  final int initialPpu;
  final int currentPpu;
  final int quantity;
  final String acr;

  factory CompanyStockModel.fromJson(Map<String, dynamic> json) =>
      CompanyStockModel(
        id: json["id"],
        name: json["name"],
        initialPpu: json["initial_ppu"],
        currentPpu: json["current_ppu"],
        quantity: json["quantity"],
        acr: json["acr"],
      );
}
