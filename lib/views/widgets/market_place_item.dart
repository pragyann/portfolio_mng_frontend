import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';
import 'package:portfolio_mng_frontend/views/screens/buyFromMarketScreen/buy_from_market_screen.dart';

class MarketPlaceItem extends StatelessWidget {
  const MarketPlaceItem({
    Key? key,
    required this.stockModel,
  }) : super(key: key);

  final MarketPlaceStockModel stockModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuyFromMarketScreen(stockModel: stockModel),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: ColorPalette.primaryColor.withOpacity(0.3),
          ),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name
              SizedBox(
                height: 40,
                width: SizeConfig.screenWidth * 0.8,
                child: Text(
                  stockModel.name,
                  maxLines: 2,
                  style: const TextStyle(
                    color: ColorPalette.secondaryColor,
                    // fontWeight: FontWeight.w500,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // acronym
                  Text(
                    stockModel.acr,
                    style: const TextStyle(
                      // color: ColorPalette.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // current ppu
                  MarketPlaceItemViewField(
                    label: 'Current PPU',
                    value: 'Rs. ${stockModel.currentPpu.toString()}',
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // quantity
                  MarketPlaceItemViewField(
                    label: 'Quantity',
                    value: stockModel.quantity.toString(),
                  ),
                  // selling ppu
                  MarketPlaceItemViewField(
                    label: 'Selling PPU',
                    value: 'Rs. ${stockModel.ppu.toString()}',
                    valueColor: stockModel.ppu < stockModel.currentPpu
                        ? Colors.green
                        : stockModel.ppu > stockModel.currentPpu
                            ? Colors.red
                            : Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MarketPlaceItemViewField extends StatelessWidget {
  const MarketPlaceItemViewField({
    Key? key,
    required this.label,
    required this.value,
    this.valueColor = Colors.black,
  }) : super(key: key);

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: Dimensions.fontSizeSmall,
            color: ColorPalette.grey(),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
