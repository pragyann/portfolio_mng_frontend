import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/helpers/date_time_converter.dart';
import 'package:portfolio_mng_frontend/utils/color_palette.dart';
import 'package:portfolio_mng_frontend/utils/dimensions.dart';
import 'package:portfolio_mng_frontend/views/widgets/profit_loss_widgets.dart';
import 'package:portfolio_mng_frontend/views/widgets/widgets.dart';

class MyPortfolioItem extends StatelessWidget {
  const MyPortfolioItem({
    Key? key,
    required this.userStockModel,
  }) : super(key: key);

  final UserStockModel userStockModel;

  @override
  Widget build(BuildContext context) {
    final total = userStockModel.quantity * userStockModel.currentPpu;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorPalette.mildGrey(),
          )),
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.paddingSizeSmall,
        horizontal: Dimensions.paddingSizeDefault,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            childrenPadding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault),
            title: _buildTitle(total),
            subtitle: _buildSubtitle(),
            children: [
              LabelValueWidget(
                label: 'Usable Unit',
                value: userStockModel.usableQty.toString(),
              ),
              LabelValueWidget(
                label: 'Total Investment',
                value: 'Rs. ${userStockModel.totalInv.toString()}',
              ),
              LabelValueWidget(
                label: 'Sold Amount',
                value: 'Rs. ${userStockModel.soldAmt.toString()}',
              ),
              // LabelValueWidget(
              //   label: 'Current Amount',
              //   value:
              //       'Rs. ${(userStockModel.quantity * userStockModel.currentPpu).toString()}',
              // ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTitle(int total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // share acronym
        Text(
          userStockModel.acr.toString(),
          style: const TextStyle(
            fontSize: Dimensions.fontSizeLarge,
            color: ColorPalette.primaryColor,
          ),
        ),
        // total price
        Text(
          'Rs. $total',
          style: const TextStyle(
            fontSize: Dimensions.fontSizeLarge,
            color: ColorPalette.primaryColor,
          ),
        )
      ],
    );
  }

  _buildSubtitle() {
    return Row(
      children: [
        Text(
          '${userStockModel.quantity} Shares, LTP: ${userStockModel.currentPpu}',
          style: TextStyle(
            color: ColorPalette.grey(),
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
        const Expanded(child: SizedBox()),
        ProfitLossWidget(profit: userStockModel.profit),
      ],
    );
  }
}
