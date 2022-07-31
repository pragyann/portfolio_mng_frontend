import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';
import 'package:portfolio_mng_frontend/views/screens/loginScreen/login_screen.dart';
import 'package:portfolio_mng_frontend/views/screens/signupScreen/signup_screen.dart';

class NoOrYesAccountWidget extends StatelessWidget {
  const NoOrYesAccountWidget({
    Key? key,
    required this.hasAccount,
  }) : super(key: key);

  final bool hasAccount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                hasAccount ? const LoginScreen() : const SignupScreen(),
          ),
        );
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: 0.5,
              color: ColorPalette.mildGrey(),
            ),
          ),
        ),
        padding:
            const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
        child: hasAccount
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Already have an account? '),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                Text('Don\'t have an account? '),
                Text(
                  'Sign up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
      ),
    );
  }
}
