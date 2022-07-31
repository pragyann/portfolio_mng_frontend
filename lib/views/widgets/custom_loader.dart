import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/utils/dimensions.dart';

showLoader(context, {bool allowPop = true, Color? barrierColor}) {
  showDialog(
    barrierColor: barrierColor,
    context: context,
    builder: (context) => CustomLoader(
      allowPop: allowPop,
    ),
  );
}

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    Key? key,
    this.allowPop = true,
    this.size = 23,
  }) : super(key: key);

  final bool allowPop;
  final double size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return allowPop;
      },
      child: const Padding(
        padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
