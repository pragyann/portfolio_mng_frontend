class AddToMarketPlaceModel {
  String stockId;
  String quantity;
  String ppu;

  AddToMarketPlaceModel({
    required this.stockId,
    required this.quantity,
    required this.ppu,
  });

  Map<String, String> toJson() => {
        'stock_id': stockId,
        'quantity': quantity,
        'ppu': ppu,
      };
}
