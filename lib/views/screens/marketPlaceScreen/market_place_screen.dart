import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/dimensions.dart';
import 'package:portfolio_mng_frontend/views/widgets/platformAdaptive/pa_refresh_control_with_slivers.dart';
import 'package:portfolio_mng_frontend/views/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({Key? key}) : super(key: key);

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Place'),
      ),
      body: Consumer<MarketStockProvider>(
        builder: (context, marketStockProvider, child) => marketStockProvider
                .gettingMarketStocks
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : PlatformAdaptiveRefreshControlWithSlivers(
                onRefresh: () async {
                  await marketStockProvider.getMarketPlaceStocks();
                },
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: EdgeInsets.only(
                          top: index == 0 ? Dimensions.paddingSizeDefault : 0,
                          bottom: Dimensions.paddingSizeDefault,
                          left: Dimensions.paddingSizeDefault,
                          right: Dimensions.paddingSizeDefault,
                        ),
                        child: MarketPlaceItem(
                          stockModel:
                              marketStockProvider.marketPlaceStocks[index],
                        ),
                      ),
                      childCount: marketStockProvider.marketPlaceStocks.length,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
