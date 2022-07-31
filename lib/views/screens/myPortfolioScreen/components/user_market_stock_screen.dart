import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';
import 'package:portfolio_mng_frontend/views/widgets/custom_alert_dialog.dart';
import 'package:portfolio_mng_frontend/views/widgets/custom_error_widget.dart';
import 'package:portfolio_mng_frontend/views/widgets/custom_loader.dart';
import 'package:portfolio_mng_frontend/views/widgets/custom_snackbar.dart';
import 'package:portfolio_mng_frontend/views/widgets/labelValueWidget.dart';
import 'package:portfolio_mng_frontend/views/widgets/platformAdaptive/pa_refresh_control_with_slivers.dart';
import 'package:provider/provider.dart';

class UserMarketStockScreen extends StatefulWidget {
  const UserMarketStockScreen({Key? key}) : super(key: key);

  @override
  State<UserMarketStockScreen> createState() => _UserMarketStockScreenState();
}

class _UserMarketStockScreenState extends State<UserMarketStockScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PortfolioProvider>(context, listen: false)
        .getUserMarketStocks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Market'),
      ),
      body: Consumer<PortfolioProvider>(
        builder: (context, portfolioProvider, child) => portfolioProvider
                .gettingUserMarketStocks
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : portfolioProvider.userMarketStocks.isEmpty
                ? const CustomErrorWidget(
                    errorMessage:
                        'You have not placed any stocks in market place.',
                  )
                : PlatformAdaptiveRefreshControlWithSlivers(
                    onRefresh: () async {
                      await portfolioProvider.getUserMarketStocks();
                    },
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => UserMarketStockItem(
                            userMarketStockModel:
                                portfolioProvider.userMarketStocks[index],
                            onRemove: () {
                              _handleRemove(
                                portfolioProvider
                                    .userMarketStocks[index].stockId
                                    .toString(),
                              );
                            },
                          ),
                          childCount: portfolioProvider.userMarketStocks.length,
                        ),
                      )
                    ],
                  ),
      ),
    );
  }

  _handleRemove(String stockId) {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: 'Remove from market.',
        message: 'Are you sure you want to remove the stock from market?',
        needSecondButton: true,
        firstButtonLabel: 'Remove',
        firstButtonOnPressed: () {
          // pop dialog
          Navigator.pop(context);
          showLoader(context, allowPop: false);

          Provider.of<PortfolioProvider>(context, listen: false)
              .removeStockFromMarket(stockId, _afterRemove);
        },
      ),
    );
  }

  _afterRemove(bool success, String message) {
    // pop loader
    Navigator.pop(context);
    if (success) {
      CustomSnackBar.showSuccessSnackBar(context, message: message);
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Failed to remove.',
          message: message,
        ),
      );
    }
  }
}

class UserMarketStockItem extends StatelessWidget {
  const UserMarketStockItem({
    Key? key,
    required this.userMarketStockModel,
    this.onRemove,
  }) : super(key: key);

  final UserMarketStockModel userMarketStockModel;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
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
      padding: const EdgeInsets.all(
        Dimensions.paddingSizeDefault,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  userMarketStockModel.name,
                  style: const TextStyle(
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onRemove,
                child: Icon(
                  Icons.close,
                  size: 22,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          LabelValueWidget(
            label: 'Quantity',
            value: userMarketStockModel.quantity.toString(),
          ),
          LabelValueWidget(
            label: 'Price Per Unit',
            value: 'Rs. ${userMarketStockModel.ppu.toString()}',
          ),
          LabelValueWidget(
            label: 'Current PPU',
            value: 'Rs. ${userMarketStockModel.currentPpu.toString()}',
          ),
        ],
      ),
    );
  }
}
