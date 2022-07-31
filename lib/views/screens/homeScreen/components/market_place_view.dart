import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';
import 'package:portfolio_mng_frontend/views/screens/marketPlaceScreen/market_place_screen.dart';
import 'package:portfolio_mng_frontend/views/widgets/home_title.dart';
import 'package:portfolio_mng_frontend/views/widgets/market_place_item.dart';
import 'package:provider/provider.dart';

class MarketPlaceView extends StatefulWidget {
  const MarketPlaceView({Key? key}) : super(key: key);

  @override
  State<MarketPlaceView> createState() => _MarketPlaceViewState();
}

class _MarketPlaceViewState extends State<MarketPlaceView> {
  late CarouselControllerImpl _sliderController;

  @override
  void initState() {
    _sliderController = CarouselControllerImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketStockProvider>(
      builder: (context, marketStockProvider, child) {
        return !marketStockProvider.gettingMarketStocks &&
                marketStockProvider.marketPlaceStocks.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeTitle(
                      title: 'Market Place',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MarketPlaceScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 130,
                      width: double.infinity,
                      child: CarouselSlider.builder(
                        carouselController: _sliderController,
                        options: CarouselOptions(
                          viewportFraction: 0.95,
                          disableCenter: true,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          autoPlayInterval: const Duration(seconds: 6),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 300),
                          onPageChanged: (index, changedReason) {
                            marketStockProvider.setSlideIndex(index);
                          },
                        ),
                        itemCount: marketStockProvider.marketPlaceStocks.length,
                        itemBuilder: (context, index, pgIndex) {
                          return marketStockProvider
                                  .marketPlaceStocks.isNotEmpty
                              ? MarketPlaceItem(
                                  stockModel: marketStockProvider
                                      .marketPlaceStocks[index],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: ColorPalette.primaryColor
                                        .withOpacity(0.3),
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
