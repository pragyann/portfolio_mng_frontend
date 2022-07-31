import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/helpers/date_time_converter.dart';
import 'package:portfolio_mng_frontend/utils/color_palette.dart';
import 'package:portfolio_mng_frontend/utils/dimensions.dart';
import 'package:portfolio_mng_frontend/views/widgets/widgets.dart';

class MyTransactionItem extends StatelessWidget {
  const MyTransactionItem({
    Key? key,
    required this.transactionModel,
  }) : super(key: key);

  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    final total = transactionModel.quantity * transactionModel.ppu;
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
                label: 'Quantity',
                value: transactionModel.quantity.toString(),
              ),
              LabelValueWidget(
                label: 'PPU',
                value: 'Rs. ${transactionModel.ppu.toString()}',
              ),
              LabelValueWidget(
                label: 'Transcation ID',
                value: transactionModel.tId.toString(),
              ),
              LabelValueWidget(
                label: 'Transaction Type',
                value: transactionModel.transacType,
              ),
              LabelValueWidget(
                label: 'Transaction Time',
                value: DateTimeConverter.dateTimeToTimeText(
                    transactionModel.transacDate),
              ),
              LabelValueWidget(
                label: 'Current PPU',
                value: 'Rs. ${transactionModel.currentPpu.toString()}',
                valueColor: transactionModel.currentPpu > transactionModel.ppu
                    ? Colors.green
                    : transactionModel.currentPpu < transactionModel.ppu
                        ? Colors.red
                        : null,
              ),
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
          transactionModel.acr.toString(),
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
          'Transaction Date',
          style: TextStyle(
            color: ColorPalette.grey(),
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          DateTimeConverter.dateTimeToDateText(transactionModel.transacDate),
          textAlign: TextAlign.right,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            fontSize: Dimensions.fontSizeSmall + 1,
          ),
        ),
      ],
    );
  }
}
