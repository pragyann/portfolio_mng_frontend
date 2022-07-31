import 'package:flutter/cupertino.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';

class LabelValueWidget extends StatelessWidget {
  const LabelValueWidget({
    Key? key,
    required this.label,
    required this.value,
    this.valueColor,
  }) : super(key: key);

  final String label;
  final String value;
  final Color? valueColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(
                color: ColorPalette.grey(),
                fontSize: Dimensions.fontSizeSmall,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: Dimensions.fontSizeSmall + 1,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
