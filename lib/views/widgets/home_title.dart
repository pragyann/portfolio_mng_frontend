import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({
    Key? key,
    required this.title,
    this.onTap,
    this.needSeeMore = true,
  }) : super(key: key);
  final String title;
  final VoidCallback? onTap;
  final bool needSeeMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: ColorPalette.darkGrey(),
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.fontSizeLarge,
                ),
              ),
            ],
          ),
          if (needSeeMore)
            InkWell(
              onTap: onTap,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Text(
                'See More',
                style: TextStyle(
                  color: ColorPalette.grey(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
