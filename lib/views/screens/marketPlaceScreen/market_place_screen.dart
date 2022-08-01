import 'package:flutter/material.dart';
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
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showCustomSearch(
                  context: context, delegate: MarketPlaceSearchDelegate());
            },
          )
        ],
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

class MarketPlaceSearchDelegate extends CustomSearchDelegate {
  MarketPlaceSearchDelegate() : super(searchFieldLabel: 'Search Market Place');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isNotEmpty) {
            query = '';
          } else {
            close(context, null);
          }
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultAndSuggestion();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResultAndSuggestion();
  }

  _buildResultAndSuggestion() {
    return Consumer<MarketStockProvider>(
      builder: (context, marketStockProvider, child) {
        final suggested =
            marketStockProvider.marketPlaceStocks.where((element) {
          final resultName = element.name.toLowerCase();
          final resultAcr = element.acr.toLowerCase();
          final input = query.toLowerCase();
          return resultName.contains(input) || resultAcr.contains(input);
        }).toList();
        return ListView.builder(
          itemCount: suggested.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
              top: index == 0 ? Dimensions.paddingSizeDefault : 0,
              bottom: Dimensions.paddingSizeDefault,
              left: Dimensions.paddingSizeDefault,
              right: Dimensions.paddingSizeDefault,
            ),
            child: MarketPlaceItem(
              stockModel: suggested[index],
            ),
          ),
        );
      },
    );
  }
}
