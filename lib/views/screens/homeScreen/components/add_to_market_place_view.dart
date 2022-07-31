import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/helpers/helpers.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';
import 'package:portfolio_mng_frontend/views/widgets/custom_snackbar.dart';
import 'package:portfolio_mng_frontend/views/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AddToMarketPlaceView extends StatefulWidget {
  const AddToMarketPlaceView({Key? key}) : super(key: key);

  @override
  State<AddToMarketPlaceView> createState() => _AddToMarketPlaceViewState();
}

class _AddToMarketPlaceViewState extends State<AddToMarketPlaceView> {
  final _quantityController = TextEditingController();
  final _quantityFocus = FocusNode();
  final _ppuController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Consumer<BuySellViewProvider>(
        builder: (context, stockProvider, child) {
          int selectedQuantity = stockProvider.selectedUserStock == null
              ? 0
              : stockProvider.selectedUserStock!.usableQty;
          int currentPPU = stockProvider.selectedUserStock == null
              ? 0
              : stockProvider.selectedUserStock!.currentPpu;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                // select stock
                Consumer<PortfolioProvider>(
                  builder: (context, porfolioProvider, child) =>
                      CustomDropDownMenu<UserStockModel>(
                    autovalidateMode: AutovalidateMode.disabled,
                    needPrefix: false,
                    label: 'Stock',
                    needLabel: true,
                    hint: 'Select a stock...',
                    isExpanded: true,
                    value: stockProvider.selectedUserStock,
                    items: List<DropdownMenuItem<UserStockModel>>.from(
                      porfolioProvider.userStocks.map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Select a stock';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      stockProvider.setSelectedUserStock(value);
                      _quantityController.clear();
                      _ppuController.clear();
                    },
                  ),
                ),
                // quantity
                CustomTextField(
                  autovalidateMode: AutovalidateMode.disabled,
                  hintText: 'Enter quantity',
                  label: 'Quantity  (MAX: $selectedQuantity)',
                  textInputType: TextInputType.number,
                  controller: _quantityController,
                  textInputAction: TextInputAction.next,
                  focusNode: _quantityFocus,
                  enabled: stockProvider.selectedUserStock != null,
                  validator: (value) {
                    if (stockProvider.selectedUserStock == null) {
                      return null;
                    }
                    return Validator.checkIfEmpty('Quantity', value);
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      // setting limit
                      if (double.parse(value).toInt() >
                          stockProvider.selectedUserStock!.usableQty) {
                        _quantityController.text = stockProvider
                            .selectedUserStock!.usableQty
                            .toString();
                        // setting cursor to end
                        _quantityController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: _quantityController.text.length));
                      }
                    }
                  },
                ),

                // PPU
                CustomTextField(
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: _ppuController,
                  enabled: stockProvider.selectedUserStock != null,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator: (text) {
                    if (stockProvider.selectedUserStock == null) {
                      return null;
                    }
                    return Validator.checkIfEmpty('PPU ', text);
                  },
                  label: 'Price Per Unit (Current: Rs. $currentPPU)',
                ),

                // buy button
                CustomButton(
                    label: 'Add to market', onPressed: _handleOnPressed),
              ],
            ),
          );
        },
      ),
    );
  }

  _handleOnPressed() {
    if (_formKey.currentState!.validate()) {
      showLoader(context, allowPop: false);
      final stockProvider =
          Provider.of<BuySellViewProvider>(context, listen: false);
      Provider.of<TransactionProvider>(context, listen: false).addToMarket(
        stockProvider.selectedUserStock!.stockId.toString(),
        _quantityController.text,
        _ppuController.text,
        _afterAddToMarket,
      );
    }
  }

  _afterAddToMarket(bool success, String message) {
    // pop loader
    Navigator.pop(context);
    if (success) {
      CustomSnackBar.showSuccessSnackBar(context, message: message);

      // clear selected data
      Provider.of<BuySellViewProvider>(context, listen: false)
          .clearSelectedUserStock();
      _quantityController.clear();
      _ppuController.clear();

      // update user stock
      Provider.of<PortfolioProvider>(context, listen: false).getUserStocks();
      // update market stock
      Provider.of<MarketStockProvider>(context, listen: false)
          .getMarketPlaceStocks();
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Failed to add to market',
          message: message,
        ),
      );
    }
  }
}
