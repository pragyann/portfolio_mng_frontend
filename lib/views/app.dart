import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/service_locator.dart';
import 'package:portfolio_mng_frontend/themes/light_theme.dart';
import 'package:portfolio_mng_frontend/views/screens/loginScreen/login_screen.dart';
import 'package:portfolio_mng_frontend/views/screens/mainScreen/main_screen.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late String _initialRoute;

  _getInitialRoute(BuildContext context) {
    bool isLoggedIn = locator<UserProvider>().isLoggedIn;
    if (isLoggedIn) {
      String token = locator<UserProvider>().user.token;
      print('User token ===> $token');
      _initialRoute = RouteNames.mainScreen;
    } else {
      _initialRoute = RouteNames.loginScreen;
    }
  }

  Future<void> _setOptimalDisplayMode() async {
    final List<DisplayMode> supported = await FlutterDisplayMode.supported;
    final DisplayMode active = await FlutterDisplayMode.active;

    final List<DisplayMode> sameResolution = supported
        .where((DisplayMode m) =>
            m.width == active.width && m.height == active.height)
        .toList()
      ..sort((DisplayMode a, DisplayMode b) =>
          b.refreshRate.compareTo(a.refreshRate));

    final DisplayMode mostOptimalMode =
        sameResolution.isNotEmpty ? sameResolution.first : active;

    await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
  }

  @override
  void initState() {
    super.initState();
    _setOptimalDisplayMode();
    _getInitialRoute(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => locator<LoginProvider>()),
        ChangeNotifierProvider(create: (context) => locator<SignupProvider>()),
        ChangeNotifierProvider(create: (context) => locator<UserProvider>()),
        ChangeNotifierProvider(
            create: (context) => locator<MainScreenProvider>()),
        ChangeNotifierProvider(
            create: (context) => locator<MarketStockProvider>()),
        ChangeNotifierProvider(
            create: (context) => locator<TransactionProvider>()),
        ChangeNotifierProvider(
            create: (context) => locator<PortfolioProvider>()),
        ChangeNotifierProvider(
            create: (context) => locator<BuySellViewProvider>()),
      ],
      builder: (context, child) => MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        initialRoute: _initialRoute,
        routes: {
          RouteNames.loginScreen: (context) => const LoginScreen(),
          RouteNames.mainScreen: (context) => const MainScreen(),
        },
      ),
    );
  }
}
