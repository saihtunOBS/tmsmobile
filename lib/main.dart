import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/language_bloc.dart';
import 'package:tmsmobile/data/app_data/app_data.dart';
import 'package:tmsmobile/pages/auth/splash_screen_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'utils/dimens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('my', 'MM')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: const TMSMobile()));
}

class TMSMobile extends StatelessWidget {
  const TMSMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageBloc>(
      create: (context) => LanguageBloc(context: context),
      child: Consumer<LanguageBloc>(
        builder: (context, value, child) => MaterialApp(
          title: 'TMS Mobile',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: AppData.shared.fontFamily,
              colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
              useMaterial3: true,
              scaffoldBackgroundColor: kBackgroundColor,
              appBarTheme: AppBarTheme(toolbarHeight: kMargin60)),
          home: const SplashScreenPage(),
        ),
      ),
    );
  }
}
