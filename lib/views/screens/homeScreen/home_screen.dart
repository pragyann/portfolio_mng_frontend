import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/color_palette.dart';
import 'package:portfolio_mng_frontend/utils/dimensions.dart';
import 'package:portfolio_mng_frontend/views/screens/homeScreen/components/components.dart';
import 'package:portfolio_mng_frontend/views/widgets/platformAdaptive/pa_refresh_control_with_slivers.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  _getData() {
    Provider.of<BuySellViewProvider>(context, listen: false).getCompanyStocks();
    Provider.of<MarketStockProvider>(context, listen: false)
        .getMarketPlaceStocks();
    Provider.of<PortfolioProvider>(context, listen: false).getUserStocks();
  }

  _refresh() async {
    await Future.wait(<Future>[
      Provider.of<BuySellViewProvider>(context, listen: false)
          .getCompanyStocks(),
      Provider.of<MarketStockProvider>(context, listen: false)
          .getMarketPlaceStocks(),
      Provider.of<PortfolioProvider>(context, listen: false).getUserStocks(),
    ]);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: PlatformAdaptiveRefreshControlWithSlivers(
            onRefresh: () async {
              await _refresh();
            },
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // App name
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppConstants.appName,
                            style: TextStyle(
                              fontSize: Dimensions.fontSizeOverLarge,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: SizedBox(
                              height: 30,
                              width: 35,
                              child: Image.asset(
                                Images.arrowRise,
                                height: 30,
                                color: ColorPalette.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // Market place view
                    const MarketPlaceView(),

                    // Buy Sell view
                    const BuySellStockView()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
