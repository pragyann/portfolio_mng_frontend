import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/data/models/company_stock_model.dart';
import 'package:portfolio_mng_frontend/helpers/helpers.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/dimensions.dart';
import 'package:portfolio_mng_frontend/views/widgets/custom_snackbar.dart';
import 'package:portfolio_mng_frontend/views/widgets/widgets.dart';
import 'package:provider/provider.dart';

class BuyFromCompanyView extends StatefulWidget {
  const BuyFromCompanyView({Key? key}) : super(key: key);

  @override
  State<BuyFromCompanyView> createState() => _BuyFromCompanyViewState();
}

class _BuyFromCompanyViewState extends State<BuyFromCompanyView>
    with AutomaticKeepAliveClientMixin {
  final _quantityController = TextEditingController();
  final _quantityFocus = FocusNode();
  final _ppuController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Consumer<BuySellViewProvider>(
        builder: (context, stockProvider, child) {
          int selectedQuantity = stockProvider.selectedCompanyStock == null
              ? 0
              : stockProvider.selectedCompanyStock!.quantity;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                // select stock
                CustomDropDownMenu<CompanyStockModel>(
                  autovalidateMode: AutovalidateMode.disabled,
                  needPrefix: false,
                  label: 'Stock',
                  needLabel: true,
                  hint: 'Select a stock...',
                  isExpanded: true,
                  value: stockProvider.selectedCompanyStock,
                  items: List<DropdownMenuItem<CompanyStockModel>>.from(
                    stockProvider.companyStocks.map(
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
                    stockProvider.setSelectedCompanyStock(value);
                    if (value != null) {
                      _ppuController.text = value.currentPpu.toString();
                    }
                    _quantityController.clear();
                  },
                ),
                // quantity
                CustomTextField(
                  autovalidateMode: AutovalidateMode.disabled,
                  hintText: 'Enter quantity',
                  label: 'Quantity  (MAX: $selectedQuantity)',
                  textInputType: TextInputType.number,
                  controller: _quantityController,
                  focusNode: _quantityFocus,
                  enabled: stockProvider.selectedCompanyStock != null,
                  validator: (value) {
                    if (stockProvider.selectedCompanyStock == null) {
                      return null;
                    }
                    return Validator.checkIfEmpty('Quantity', value);
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      // setting limit
                      if (double.parse(value).toInt() >
                          stockProvider.selectedCompanyStock!.quantity) {
                        _quantityController.text = stockProvider
                            .selectedCompanyStock!.quantity
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
                  readOnly: true,
                  controller: _ppuController,
                  label: 'Price Per Unit (In Rs.)',
                ),

                // buy button
                CustomButton(
                  label: 'Buy',
                  onPressed: _handleBuy,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _handleBuy() {
    if (_formKey.currentState!.validate()) {
      showLoader(context, allowPop: false);
      final stockProvider =
          Provider.of<BuySellViewProvider>(context, listen: false);
      Provider.of<TransactionProvider>(context, listen: false).buyFromCompany(
        stockProvider.selectedCompanyStock!.id.toString(),
        _quantityController.text,
        _afterBuy,
      );
    }
  }

  _afterBuy(bool success, String message) {
    // pop loader
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
      // upate company stock
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
