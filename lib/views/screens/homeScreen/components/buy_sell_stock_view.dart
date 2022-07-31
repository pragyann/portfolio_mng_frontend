import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/color_palette.dart';
import 'package:portfolio_mng_frontend/utils/dimensions.dart';
import 'package:portfolio_mng_frontend/views/screens/homeScreen/components/components.dart';
import 'package:provider/provider.dart';

class BuySellStockView extends StatefulWidget {
  const BuySellStockView({Key? key}) : super(key: key);

  @override
  State<BuySellStockView> createState() => _BuySellStockViewState();
}

class _BuySellStockViewState extends State<BuySellStockView> {
  final _pageController = PageController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<BuySellViewProvider>(context, listen: false)
          .clearSelectedCompanyStock();
      Provider.of<BuySellViewProvider>(context, listen: false)
          .clearSelectedUserStock();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault,
        vertical: Dimensions.paddingSizeSmall,
      ),
      child: Consumer<BuySellViewProvider>(
        builder: (context, buySellViewProvider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  buySellViewProvider.selectedIndex == 0
                      ? 'Buy from company'
                      : 'Add to Market Place',
                  style: TextStyle(
                    color: ColorPalette.darkGrey(),
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    buySellViewProvider.toggleIndex();
                    // _pageController
                    //     .jumpToPage(buySellViewProvider.selectedIndex);
                  },
                  child: SizedBox(
                    height: 26,
                    child: Image.asset(
                      Images.switchh,
                      color: ColorPalette.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: ColorPalette.lightGrey(),
                    blurRadius: 2,
                    spreadRadius: 2,
                  )
                ],
              ),
              // child: PageView(
              //   controller: _pageController,
              //   children: const [
              //     BuyFromCompanyView(),
              //     AddToMarketPlaceView(),
              //   ],
              // ),
              child: IndexedStack(
                index: buySellViewProvider.selectedIndex,
                children: const [
                  BuyFromCompanyView(),
                  AddToMarketPlaceView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
