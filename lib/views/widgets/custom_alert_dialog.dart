import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';
import 'package:portfolio_mng_frontend/views/widgets/widgets.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    this.message,
    this.firstButtonOnPressed,
    this.firstButtonLabel = 'Ok',
    this.secondButtonLabel = 'Cancel',
    this.needSecondButton = false,
    this.secondButtonOnPressed,
    required this.title,
  }) : super(key: key);

  final String title;
  final String? message;
  final VoidCallback? firstButtonOnPressed;
  final VoidCallback? secondButtonOnPressed;
  final String firstButtonLabel;
  final String secondButtonLabel;
  final bool needSecondButton;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      title: Center(
          child: Text(
        title,
        textAlign: TextAlign.center,
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (message != null) ...[
            Text(
              message!,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
          ],
          CustomButton(
            height: 40,
            label: firstButtonLabel,
            onPressed: firstButtonOnPressed ??
                () {
                  Navigator.pop(context);
                },
          ),
          if (needSecondButton) ...[
            const SizedBox(height: Dimensions.paddingSizeDefault),
            CustomButton(
              label: secondButtonLabel,
              outlined: true,
              height: 40,
              onPressed: secondButtonOnPressed ??
                  () {
                    Navigator.pop(context);
                  },
            ),
          ],
        ],
      ),
      titlePadding: const EdgeInsets.only(
        top: Dimensions.paddingSizeLarge,
        left: Dimensions.paddingSizeLarge,
        right: Dimensions.paddingSizeLarge,
      ),
      insetPadding:
          EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.15),
    );
  }
}
