import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/helpers/helpers.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';
import 'package:portfolio_mng_frontend/views/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _confirmPassFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !Provider.of<SignupProvider>(context, listen: false).signingUp;
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
                      padding: const EdgeInsets.all(
                          Dimensions.paddingSizeExtraLarge),
                      child: Form(
                        key: _formKey,
                        child: Consumer<SignupProvider>(
                          builder: (context, signupProvider, child) => Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Create an account',
                                style: TextStyle(
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 30),
                              CustomTextField(
                                controller: _nameController,
                                focusNode: _nameFocus,
                                hintText: 'Enter your full name',
                                nextNode: _phoneFocus,
                                textInputAction: TextInputAction.next,
                                enabled: !signupProvider.signingUp,
                                validator: (text) {
                                  return Validator.checkIfEmpty(
                                      'Full name', text);
                                },
                              ),
                              CustomTextField(
                                controller: _phoneController,
                                focusNode: _phoneFocus,
                                hintText: 'Enter your phone number',
                                nextNode: _emailFocus,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.number,
                                enabled: !signupProvider.signingUp,
                                validator: Validator.validatePhoneNumber,
                              ),
                              CustomTextField(
                                controller: _emailController,
                                focusNode: _emailFocus,
                                hintText: 'Enter your email',
                                nextNode: _passFocus,
                                textInputAction: TextInputAction.next,
                                enabled: !signupProvider.signingUp,
                                validator: Validator.validateEmail,
                              ),
                              CustomPasswordField(
                                controller: _passController,
                                focusNode: _passFocus,
                                nextNode: _confirmPassFocus,
                                hintText: 'Enter your password',
                                textInputAction: TextInputAction.next,
                                enabled: !signupProvider.signingUp,
                                validator: Validator.validatePassword,
                              ),
                              CustomPasswordField(
                                focusNode: _confirmPassFocus,
                                hintText: 'Confirm your password',
                                textInputAction: TextInputAction.done,
                                enabled: !signupProvider.signingUp,
                                validator: (text) {
                                  if (text != _passController.text) {
                                    return 'Passwords do not match.';
                                  }
                                  return Validator.validatePassword(text);
                                },
                              ),
                              CustomButton(
                                width: double.infinity,
                                label: 'Sign Up',
                                isLoading: signupProvider.signingUp,
                                loadingMsg: 'Signing up...',
                                onPressed: _signup,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    const NoOrYesAccountWidget(
                      hasAccount: true,
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

  _signup() {
    if (_formKey.currentState!.validate()) {
      Provider.of<SignupProvider>(context, listen: false).signup(
        _emailController.text,
        _passController.text,
        _nameController.text,
        _phoneController.text,
        _afterSignup,
      );
    }
  }

  _afterSignup(bool success, String message) {
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
          title: 'Signup Failed.',
          message: message,
        ),
      );
    }
  }
}
