import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/constants/constants.dart';
import 'package:portfolio_mng_frontend/providers/providers.dart';
import 'package:portfolio_mng_frontend/utils/color_palette.dart';
import 'package:portfolio_mng_frontend/utils/dimensions.dart';
import 'package:portfolio_mng_frontend/views/screens/loginScreen/login_screen.dart';
import 'package:portfolio_mng_frontend/views/screens/profileScreen/components/profile_screen_item.dart';
import 'package:portfolio_mng_frontend/views/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) => Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: ColorPalette.primaryColor.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                    )
                  ],
                ),
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    Images.defaultDp,
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Name
              Text(
                userProvider.user.name,
                style: const TextStyle(
                  fontSize: Dimensions.fontSizeExtraLarge,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Email
              ProfileScreenItem(
                label: 'Email',
                value: userProvider.user.email,
              ),

              // Contact no
              ProfileScreenItem(
                label: 'Contact Number',
                value: userProvider.user.contact,
              ),
              const SizedBox(height: 20),

              // logout button
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: CustomButton(
                  label: 'Logout',
                  onPressed: _logout,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _logout() async {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: 'Log out? ',
        message: 'Are you sure you want to log out?',
        firstButtonOnPressed: () async {
          // pop dialog
          Navigator.pop(context);
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const CustomLoader());
          Provider.of<LoginProvider>(context, listen: false)
              .logout(_afterLogout);
        },
        firstButtonLabel: 'Log out',
        needSecondButton: true,
      ),
    );
  }

  _afterLogout(bool success, String message) {
    if (success) {
      Provider.of<MarketStockProvider>(context, listen: false).clear();
      Provider.of<PortfolioProvider>(context, listen: false).clear();
      Provider.of<TransactionProvider>(context, listen: false).clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Log out failed.',
          message: message,
        ),
      );
    }
  }
}
