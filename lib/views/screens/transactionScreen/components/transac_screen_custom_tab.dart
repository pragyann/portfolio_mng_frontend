import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/views/screens/transactionScreen/components/my_transaction_item.dart';
import 'package:portfolio_mng_frontend/views/widgets/custom_error_widget.dart';

class TransactionScreenCustomTab extends StatelessWidget {
  const TransactionScreenCustomTab({
    Key? key,
    required this.transactionModels,
    this.showDeliveryStatus = false,
    this.showPaymentStatus = false,
    required this.tabName,
  }) : super(key: key);

  final List<TransactionModel> transactionModels;
  final bool showDeliveryStatus;
  final bool showPaymentStatus;
  final String tabName;

  @override
  Widget build(BuildContext context) {
    return transactionModels.isEmpty
        ? CustomErrorWidget(
            errorMessage: 'No $tabName stocks.',
          )
        : ListView.builder(
            itemCount: transactionModels.length,
            itemBuilder: (context, index) {
              return MyTransactionItem(
                transactionModel: transactionModels[index],
              );
            },
          );
  }
}
