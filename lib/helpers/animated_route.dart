import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedRoute {
  static Route noAnimation(Widget onPressedPage, {String? routeName}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) => onPressedPage,
    );
  }

  static Route slideFromBottomRoute(Widget onPressedPage,
      {int duration = 100,
      Curve curve = Curves.decelerate,
      String? routeName}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      pageBuilder: (context, _, __) => onPressedPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
