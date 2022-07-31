import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const ForgotPasswordScreen()));
      },
      child: Container(
        color: Colors.transparent,
        padding:
            const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: const Text(
          'Forgort Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
