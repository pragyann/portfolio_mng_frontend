import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';
import 'package:portfolio_mng_frontend/views/widgets/custom_button.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    Key? key,
    this.errorMessage = 'An error occured.',
    this.fontSize = Dimensions.fontSizeOverLarge,
    this.refreshButtonOnPressed,
  }) : super(key: key);

  final String errorMessage;
  final double fontSize;
  final VoidCallback? refreshButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Images.appLogo,
            height: 200,
            width: 280,
            color: Colors.grey.shade300,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge),
            child: Text(
              errorMessage,
              style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          if (refreshButtonOnPressed != null)
            CustomButton(
              label: 'Try again',
              onPressed: refreshButtonOnPressed,
            ),
        ],
      ),
    );
  }
}
