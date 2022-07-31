import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    Key? key,
    this.controller,
    this.focusNode,
    this.nextNode,
    this.textInputAction,
    this.enabled = true,
    required this.hintText,
    this.needLabel = false,
    this.label = '',
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;

  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final String? hintText;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool needLabel;
  final String label;
  final String? Function(String?)? validator;
  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    toggleObscureText() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.needLabel) ...[
          Text(
            widget.label,
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
            obscureText: _obscureText,
            controller: widget.controller,
            focusNode: widget.focusNode,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(widget.nextNode);
            },
            validator: widget.validator,
            cursorRadius: const Radius.elliptical(10, 10),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: _obscureText ? Colors.grey : ColorPalette.primaryColor,
                ),
                onPressed: toggleObscureText,
              ),
              contentPadding: const EdgeInsets.only(
                left: 10,
              ),
              hintText: widget.hintText,
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
