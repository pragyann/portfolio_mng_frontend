import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/data/models/models.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';
import 'package:portfolio_mng_frontend/views/screens/transactionScreen/components/components.dart';
import 'package:portfolio_mng_frontend/views/widgets/custom_loader.dart';
import 'package:provider/provider.dart';

class MyTransactionScreen extends StatefulWidget {
  const MyTransactionScreen({Key? key}) : super(key: key);

  @override
  State<MyTransactionScreen> createState() => _MyTransactionScreenState();
}

class _MyTransactionScreenState extends State<MyTransactionScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false)
        .getUserTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Transactions'),
      ),
      body: Provider.of<TransactionProvider>(context).gettingUserTransacs
          ? const CustomLoader()
          : DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  _buildTabBar(),
                  _buildTabBarView(),
                ],
              ),
            ),
      // body: Consumer<TransactionProvider>(
      //   builder: (context, transactionProvider, child) => transactionProvider
      //           .gettingUserTransacs
      //       ? const Center(
      //           child: CircularProgressIndicator(),
      //         )
      //       : PlatformAdaptiveRefreshControlWithSlivers(
      //           onRefresh: () async {
      //             await transactionProvider.getUserTransactions();
      //           },
      //           slivers: [
      //             SliverList(
      //               delegate: SliverChildBuilderDelegate(
      //                 (context, index) => MyTransactionItem(
      //                     transactionModel:
      //                         transactionProvider.userTransactions[index]),
      //                 childCount: transactionProvider.userTransactions.length,
      //               ),
      //             )
      //           ],
      //         ),
      // ),
    );
  }

  _buildTabBar() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0.5,
          blurRadius: 1,
          offset: const Offset(0, 0), // changes position of shadow
        ),
      ]),
      child: TabBar(
        unselectedLabelColor: Colors.grey.shade800,
        labelColor: ColorPalette.primaryColor,
        labelStyle: const TextStyle(
            fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.bold),
        indicatorColor: ColorPalette.primaryColor,
        labelPadding: const EdgeInsets.symmetric(horizontal: 20),
        tabs: const [
          Tab(
            child: Text('All'),
          ),
          Tab(
            child: Text('Bought'),
          ),
          Tab(
            child: Text('Sold'),
          ),
        ],
      ),
    );
  }

  _buildTabBarView() {
    return Expanded(
      child: Consumer<TransactionProvider>(
        builder: (context, provider, child) => TabBarView(
          children: [
            // All
            TransactionScreenCustomTab(
              transactionModels: provider.userTransactions,
              tabName: 'All',
              showDeliveryStatus: true,
              showPaymentStatus: true,
            ),
            // Bought
            TransactionScreenCustomTab(
              transactionModels: List<TransactionModel>.from(provider
                  .userTransactions
                  .where((element) => element.transacType == 'Buy')),
              tabName: 'Bought',
              showDeliveryStatus: true,
              showPaymentStatus: true,
            ),
            // Sold
            TransactionScreenCustomTab(
              transactionModels: List<TransactionModel>.from(provider
                  .userTransactions
                  .where((element) => element.transacType == 'Sell')),
              tabName: 'Sold',
              showDeliveryStatus: true,
              showPaymentStatus: true,
            ),
          ],
        ),
      ),
    );
  }
}
