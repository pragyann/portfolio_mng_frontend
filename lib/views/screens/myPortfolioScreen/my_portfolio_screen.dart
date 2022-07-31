import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';
import 'package:portfolio_mng_frontend/views/screens/myPortfolioScreen/components/components.dart';
import 'package:portfolio_mng_frontend/views/screens/myPortfolioScreen/components/my_portfolio_item.dart';
import 'package:portfolio_mng_frontend/views/widgets/custom_error_widget.dart';
import 'package:portfolio_mng_frontend/views/widgets/platformAdaptive/pa_refresh_control_with_slivers.dart';
import 'package:portfolio_mng_frontend/views/widgets/profit_loss_widgets.dart';
import 'package:provider/provider.dart';

class MyPortfolioScreen extends StatefulWidget {
  const MyPortfolioScreen({Key? key}) : super(key: key);

  @override
  State<MyPortfolioScreen> createState() => _MyPortfolioScreenState();
}

class _MyPortfolioScreenState extends State<MyPortfolioScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PortfolioProvider>(context, listen: false).getUserStocks();
    Future.delayed(Duration.zero, () {
      Provider.of<BuySellViewProvider>(context, listen: false)
          .clearSelectedUserStock();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portfolio '),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserMarketStockScreen()));
            },
            child: const Text('My Market'),
          )
        ],
      ),
      body: Consumer<PortfolioProvider>(
          builder: (context, portfolioProvider, child) {
        var totalUnit = 0;
        var totalInv = 0;
        var soldAmt = 0;
        var currAmt = 0;
        var profit = 0;
        for (var e in portfolioProvider.userStocks) {
          totalUnit += e.quantity;
          totalInv += e.totalInv;
          soldAmt += e.soldAmt;
          currAmt += e.quantity * e.currentPpu;
          profit += e.profit;
        }
        return portfolioProvider.gettingUserStocks
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : portfolioProvider.userStocks.isEmpty
                ? const CustomErrorWidget(
                    errorMessage: 'You do not have any stocks.',
                  )
                : PlatformAdaptiveRefreshControlWithSlivers(
                    onRefresh: () async {
                      await portfolioProvider.getUserStocks();
                    },
                    slivers: [
                      SliverToBoxAdapter(
                        child: _buildOverallTotal(
                          totalUnit,
                          totalInv,
                          soldAmt,
                          currAmt,
                          profit,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => MyPortfolioItem(
                              userStockModel:
                                  portfolioProvider.userStocks[index]),
                          childCount: portfolioProvider.userStocks.length,
                        ),
                      )
                    ],
                  );
      }),
    );
  }

  _buildOverallTotal(
    totalUnit,
    totalInv,
    soldAmt,
    currAmt,
    profit,
  ) {
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
      child: ListTile(
        contentPadding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Current Share Value',
                  style: TextStyle(
                    fontSize: Dimensions.fontSizeSmall,
                    color: ColorPalette.primaryColor,
                  ),
                ),
                const SizedBox(height: 5),

                // total price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Rs. ',
                      style: TextStyle(
                        fontSize: Dimensions.fontSizeSmall,
                        color: ColorPalette.primaryColor,
                      ),
                    ),
                    Text(
                      currAmt.toString(),
                      style: const TextStyle(
                        fontSize: Dimensions.fontSizeExtraLarge,
                        color: ColorPalette.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),

            // Profit
            ProfitLossWidget(profit: profit),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Total Unit: $totalUnit',
              style: const TextStyle(
                fontSize: Dimensions.fontSizeSmall,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Inv.: Rs. $totalInv',
                  style: const TextStyle(
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                ),
                Text(
                  'Sold Amount: Rs. $soldAmt',
                  style: const TextStyle(
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
