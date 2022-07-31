import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/utils/color_palette.dart';
import 'package:portfolio_mng_frontend/utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.height,
    this.width,
    this.outlined = false,
    this.isLoading = false,
    this.fontSize = Dimensions.fontSizeDefault,
    this.enabled = true,
    this.needBorderForOutlined = true,
    this.child,
    this.loadingMsg,
    this.backgroundColor = ColorPalette.primaryColor,
    this.fontColor = Colors.white,
    this.borderColor = ColorPalette.primaryColor,
    this.outlinedFontColor = ColorPalette.primaryColor,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    this.loaderSize = 24,
  }) : super(key: key);

  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final bool outlined;
  final bool isLoading;
  final double fontSize;
  final bool enabled;
  final bool needBorderForOutlined;
  final Widget? child;
  final String? loadingMsg;
  final Color backgroundColor;
  final Color fontColor;
  final Color borderColor;
  final Color outlinedFontColor;
  final EdgeInsets padding;
  final double loaderSize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 45,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: padding,
          backgroundColor: outlined
              ? Colors.transparent
              : enabled
                  ? backgroundColor
                  : ColorPalette.lightDarkGrey(),
          shape: RoundedRectangleBorder(
            side: outlined
                ? needBorderForOutlined
                    ? BorderSide(color: borderColor)
                    : BorderSide.none
                : BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: isLoading || !enabled ? null : onPressed,
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: loaderSize,
                    width: loaderSize,
                    child: CircularProgressIndicator.adaptive(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(outlined
                            ? ColorPalette.primaryColor
                            : Colors.white)),
                  ),
                  if (loadingMsg != null) ...[
                    const SizedBox(width: 20),
                    Text(
                      loadingMsg!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                      ),
                    )
                  ]
                ],
              )
            : child ??
                Text(
                  label,
                  style: TextStyle(
                    color: outlined
                        ? outlinedFontColor
                        : enabled
                            ? fontColor
                            : Colors.grey,
                    fontSize: fontSize,
                  ),
                ),
      ),
    );
  }
}
