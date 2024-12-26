// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/auth/login_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/gradient_text.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pushAndRemoveUntil(
              context,
              createRoute(
                LoginPage(),
              ),
              (route) => false);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              SizedBox(
                height: 120,
                width: 80,
                child: Image.asset(
                  kAppLogoImage,
                  fit: BoxFit.cover,
                ),
              ),
              GradientText(kAppLabel,
                  style: GoogleFonts.crimsonPro(
                      fontSize: kTextRegular28, height: 1.1),
                  gradient:
                      LinearGradient(colors: [kPrimaryColor, kSecondaryColor]))
            ],
          ),
        ),
      ),
    );
  }
}
