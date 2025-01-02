// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tmsmobile/data/app_data/app_data.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/auth/login_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/gradient_text.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(
            context,
            createRoute(
              LoginPage(),
            ),
            (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: kSize120,
                  width: kSize80,
                  child: Image.asset(
                    kAppLogoImage,
                    fit: BoxFit.cover,
                  ),
                ),
                kMarginMedium2.vGap,
                GradientText(kAppLabel,
                    style: TextStyle(
                        fontFamily: AppData.shared.fontFamily2,
                        fontSize: kTextRegular28,
                        height: 1.1),
                    gradient: LinearGradient(
                        colors: [kPrimaryColor, kSecondaryColor])),
              ],
            ),
          ),
          _buildTopAnimation(context),
          Positioned(bottom: 0, child: _buildBottonAnimation(context))
        ],
      ),
    );
  }

  Widget _buildTopAnimation(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 1000),
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: SizedBox(
          height: value * MediaQuery.of(context).size.height * 0.24,
          child: child,
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          kAppBarTopImage,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildBottonAnimation(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 1000),
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: SizedBox(
          height: value * MediaQuery.of(context).size.height * 0.21,
          child: child,
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          kAppBarBottonImage,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
