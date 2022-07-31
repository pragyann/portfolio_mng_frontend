import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/data/models/market_place_stock_model.dart';
import 'package:portfolio_mng_frontend/helpers/helpers.dart';
import 'package:portfolio_mng_frontend/providers/market_stock_provider.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/dimensions.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';
import 'package:portfolio_mng_frontend/views/widgets/custom_snackbar.dart';
import 'package:portfolio_mng_frontend/views/widgets/widgets.dart';
import 'package:provider/provider.dart';

class BuyFromMarketScreen extends StatefulWidget {
  const BuyFromMarketScreen({
    Key? key,
    required this.stockModel,
  }) : super(key: key);

  final MarketPlaceStockModel stockModel;

  @override
  State<BuyFromMarketScreen> createState() => _BuyFromMarketScreenState();
}

class _BuyFromMarketScreenState extends State<BuyFromMarketScreen> {
  final _quantityController = TextEditingController();
  final _quantityFocus = FocusNode();
  final _ppuController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _ppuController.text = widget.stockModel.ppu.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy From Market Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Form(
          key: _formKey,
          child: Consumer<MarketStockProvider>(
            builder: (context, marketStockProvider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // stock name
                Text(
                  '${widget.stockModel.name} (${widget.stockModel.acr})',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                ),
                const SizedBox(height: 20),
                // quantity
                CustomTextField(
                  autovalidateMode: AutovalidateMode.disabled,
                  hintText: 'Enter quantity',
                  label: 'Quantity  (MAX: ${widget.stockModel.quantity})',
                  textInputType: TextInputType.number,
                  controller: _quantityController,
                  focusNode: _quantityFocus,
                  validator: (value) {
                    return Validator.checkIfEmpty('Quantity', value);
                  },
                  onChanged: (value) {
                    // setting limit
                    if (double.parse(value).toInt() >
                        widget.stockModel.quantity) {
                      _quantityController.text =
                          widget.stockModel.quantity.toString();
                      // setting cursor to end
                      _quantityController.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset: _quantityController.text.length));
                    }
                  },
                ),

                // PPU
                CustomTextField(
                  autovalidateMode: AutovalidateMode.disabled,
                  readOnly: true,
                  controller: _ppuController,
                  label: 'Price Per Unit',
                  validator: (value) {
                    return Validator.checkIfEmpty('PPU', value);
                  },
                ),

                // buy button
                CustomButton(
                  label: 'Buy',
                  onPressed: _handleBuy,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleBuy() {
    if (_formKey.currentState!.validate()) {
      showLoader(context, allowPop: false);
      Provider.of<TransactionProvider>(context, listen: false).buyFromMarket(
        widget.stockModel.saleId.toString(),
        _quantityController.text,
        _afterBuy,
      );
    }
  }

  _afterBuy(bool success, String message) {
    // pop loader and market screen
    Navigator.pop(context);
    Navigator.pop(context);

    if (success) {
      CustomSnackBar.showSuccessSnackBar(context, message: message);

      // clear selected data
      Provider.of<BuySellViewProvider>(context, listen: false)
          .clearSelectedCompanyStock();
      Provider.of<BuySellViewProvider>(context, listen: false)
          .clearSelectedUserStock();
      _quantityController.clear();
      _ppuController.clear();

      // update user stock
      Provider.of<PortfolioProvider>(context, listen: false).getUserStocks();
      // update market stock
      Provider.of<MarketStockProvider>(context, listen: false)
          .getMarketPlaceStocks();
      // update company stock
      Provider.of<BuySellViewProvider>(context, listen: false)
          .getCompanyStocks();
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Failed to Buy',
          message: message,
        ),
      );
    }
  }
}
