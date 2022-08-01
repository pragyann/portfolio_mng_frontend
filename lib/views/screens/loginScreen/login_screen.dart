import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/helpers/helpers.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';
import 'package:portfolio_mng_frontend/views/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return WillPopScope(
      onWillPop: () async {
        return !Provider.of<LoginProvider>(context, listen: false).logginin;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: SizeConfig.screenHeightWithoutStatusBar,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeExtraLarge),
                      child: Form(
                        key: _formKey,
                        child: Consumer<LoginProvider>(
                          builder: (context, loginProvider, child) => Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Center(
                                child: Image.asset(
                                  Images.appLogo,
                                  height: SizeConfig.screenHeight * 0.18,
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 30),
                              CustomTextField(
                                controller: _emailController,
                                focusNode: _emailFocus,
                                hintText: 'Enter your email',
                                nextNode: _passFocus,
                                textInputAction: TextInputAction.next,
                                enabled: !loginProvider.logginin,
                                validator: Validator.validateEmail,
                              ),
                              CustomPasswordField(
                                controller: _passController,
                                focusNode: _passFocus,
                                hintText: 'Enter your password',
                                textInputAction: TextInputAction.done,
                                enabled: !loginProvider.logginin,
                                validator: Validator.validatePassword,
                              ),
                              CustomButton(
                                width: double.infinity,
                                label: 'Login',
                                isLoading: loginProvider.logginin,
                                loadingMsg: 'Loggin in...',
                                onPressed: _login,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    const NoOrYesAccountWidget(
                      hasAccount: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login() {
    if (_formKey.currentState!.validate()) {
      Provider.of<LoginProvider>(context, listen: false)
          .login(_emailController.text, _passController.text, _afterLogin);
    }
  }

  _afterLogin(bool success, String message) {
    if (success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.mainScreen,
        (route) => false,
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Login Failed.',
          message: message,
        ),
      );
    }
  }
}
