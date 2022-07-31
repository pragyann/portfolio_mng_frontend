import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/size_config.dart';
import 'package:portfolio_mng_frontend/views/screens/homeScreen/home_screen.dart';
import 'package:portfolio_mng_frontend/views/screens/mainScreen/components/components.dart';
import 'package:portfolio_mng_frontend/views/screens/myPortFolioScreen/my_portfolio_screen.dart';
import 'package:portfolio_mng_frontend/views/screens/profileScreen/profile_screen.dart';
import 'package:portfolio_mng_frontend/views/screens/transactionScreen/my_transactions_screen.dart';
import 'package:portfolio_mng_frontend/views/widgets/custom_alert_dialog.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MainScreenProvider>(context, listen: false).init(0);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      bottomNavigationBar: const MainScreenBottomNavBar(),
      body: Consumer<MainScreenProvider>(
        builder: (context, mainScreenProvider, child) {
          PageController pageController = mainScreenProvider.pageController;
          return WillPopScope(
            onWillPop: () async {
              bool quit = false;
              if (pageController.page != 0) {
                // set to home screen
                mainScreenProvider.setPageIndex(0);
              } else {
                await showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Quit App?',
                    message: 'Are you sure you want to quit the app?',
                    firstButtonOnPressed: () {
                      Navigator.pop(context);
                      quit = true;
                    },
                    firstButtonLabel: 'Yes',
                    needSecondButton: true,
                  ),
                );
              }
              return quit;
            },
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomeScreen(),
                MyPortfolioScreen(),
                MyTransactionScreen(),
                ProfileScreen(),
              ],
            ),
          );
        },
      ),
    );
  }
}
