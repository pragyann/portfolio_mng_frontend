import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';

class CustomDropDownMenu<T> extends StatelessWidget {
  const CustomDropDownMenu({
    Key? key,
    this.label = '',
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
    this.enabled = true,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.prefixIcon = Icons.location_city,
    this.needPrefix = true,
    this.needLabel = false,
    this.isExpanded = false,
  }) : super(key: key);

  final String label;
  final String hint;
  final List<DropdownMenuItem<T>> items;
  final Function(T?)? onChanged;
  final T? value;
  final bool enabled;
  final String? Function(T?)? validator;
  final AutovalidateMode autovalidateMode;
  final IconData prefixIcon;
  final bool needPrefix;
  final bool needLabel;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (needLabel) ...[
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: ColorPalette.darkGrey(),
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.01,
          ),
        ],
        DropdownButtonFormField<T>(
          isExpanded: isExpanded,
          value: value,
          elevation: 2,
          hint: Text(hint),
          items: items,
          autovalidateMode: autovalidateMode,
          validator: validator,
          onChanged: enabled ? onChanged : null,
          decoration: InputDecoration(
            prefixIcon: needPrefix
                ? Icon(
                    prefixIcon,
                    color: ColorPalette.primaryColor,
                  )
                : null,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(width: 1.2, color: ColorPalette.mildGrey()),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(width: 1.2, color: ColorPalette.mildGrey()),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(width: 1.2, color: ColorPalette.mildGrey()),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(width: 1.2, color: ColorPalette.mildGrey()),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(width: 1.2, color: ColorPalette.mildGrey()),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
