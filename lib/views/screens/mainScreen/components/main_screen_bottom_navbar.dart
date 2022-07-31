import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/color_palette.dart';
import 'package:portfolio_mng_frontend/utils/dimensions.dart';
import 'package:provider/provider.dart';

class MainScreenBottomNavBar extends StatelessWidget {
  const MainScreenBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenProvider>(
      builder: (context, mainScreenProvider, child) => Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          iconSize: 30,
          currentIndex: mainScreenProvider.pageIndex,
          onTap: mainScreenProvider.setPageIndex,
          unselectedFontSize: Dimensions.fontSizeSmall,
          selectedFontSize: Dimensions.fontSizeSmall,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Image.asset(
                  Images.portfolio,
                  height: 24,
                  color: mainScreenProvider.pageIndex == 1
                      ? ColorPalette.primaryColor
                      : ColorPalette.grey(),
                ),
              ),
              label: 'My Portfolio',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Image.asset(
                  Images.transaction,
                  height: 24,
                  color: mainScreenProvider.pageIndex == 2
                      ? ColorPalette.primaryColor
                      : ColorPalette.grey(),
                ),
              ),
              label: 'Add New',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
