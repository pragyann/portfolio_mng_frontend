import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';

class ProfileScreenItem extends StatelessWidget {
  const ProfileScreenItem({
    Key? key,
    required this.label,
    required this.value,
    this.onTap,
  }) : super(key: key);

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: Dimensions.marginSizeExtraLarge),
        child: Row(
          children: [
            Text(label),
            const SizedBox(
              width: 50,
            ),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.right,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ColorPalette.grey()),
              ),
            ),
            // const SizedBox(width: 5),
            // Icon(
            //   Icons.chevron_right,
            //   color: ColorPalette.grey(),
            // ),
          ],
        ),
      ),
    );
  }
}
