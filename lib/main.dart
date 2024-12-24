import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tmsmobile/data/app_data/app_data.dart';
import 'package:tmsmobile/pages/auth/splash_screen_page.dart';
import 'package:tmsmobile/utils/colors.dart';

void main() async {
  await GetStorage.init();
  runApp(const TMSMobile());
}

class TMSMobile extends StatelessWidget {
  const TMSMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMS Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: AppData.shared.fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
          useMaterial3: true,
          scaffoldBackgroundColor: kBackgroundColor,
          appBarTheme: AppBarTheme(toolbarHeight: 60)),
      home: const SplashScreenPage(),
    );
  }
}
