import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.focusNode,
    this.controller,
    this.nextNode,
    this.needPrefix = false,
    this.textInputType,
    this.prefixIcon = Icons.person,
    this.textInputAction,
    this.hintText = '',
    this.enabled = true,
    this.onTap,
    this.readOnly = false,
    this.label = '',
    this.onChanged,
    this.validator,
    this.autoFocus = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.maxLines,
    this.maxLength,
  }) : super(key: key);

  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String hintText;
  final bool needPrefix;
  final IconData prefixIcon;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final String label;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool autoFocus;
  final AutovalidateMode? autovalidateMode;
  final int? maxLines;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
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
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: TextFormField(
            style: const TextStyle(
              fontSize: Dimensions.fontSizeDefault,
              textBaseline: TextBaseline.alphabetic,
            ),
            autofocus: autoFocus,
            autovalidateMode: autovalidateMode,
            validator: validator,
            onChanged: onChanged,
            onTap: onTap,
            readOnly: readOnly,
            enabled: enabled,
            controller: controller,
            focusNode: focusNode,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(nextNode);
            },
            maxLines: maxLines,
            maxLength: maxLength,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            cursorRadius: const Radius.elliptical(10, 10),
            decoration: InputDecoration(
              contentPadding: needPrefix
                  ? const EdgeInsets.symmetric(vertical: 5)
                  : const EdgeInsets.all(
                      10,
                    ),
              prefixIcon: needPrefix ? Icon(prefixIcon) : null,
              hintText: hintText,
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
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
