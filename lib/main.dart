import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/add_resident_bloc.dart';
import 'package:tmsmobile/bloc/complaint_bloc.dart';
import 'package:tmsmobile/bloc/edit_resident_bloc.dart';
import 'package:tmsmobile/bloc/epc_bloc.dart';
import 'package:tmsmobile/bloc/house_hold_bloc.dart';
import 'package:tmsmobile/bloc/language_bloc.dart';
import 'package:tmsmobile/bloc/owner_nrc_bloc.dart';
import 'package:tmsmobile/bloc/nrc_bloc.dart';
import 'package:tmsmobile/bloc/service_request_bloc.dart';
import 'package:tmsmobile/bloc/tabbar_bloc.dart';
import 'package:tmsmobile/data/app_data/app_data.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/pages/auth/splash_screen_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'bloc/invoice_detai_bloc.dart';
import 'utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> TabbarBloc()),
    ChangeNotifierProvider(create: (_) => NRCBloc()),
    ChangeNotifierProvider(create: (_) => OwnerNRCBloc()),
    ChangeNotifierProvider(create: (_) => AddResidentBloc()),
    ChangeNotifierProvider(create: (_) => EditResidentBloc()),
    ChangeNotifierProvider(create: (_) => HouseHoldBloc()),
    ChangeNotifierProvider(create: (_) => ServiceRequestBloc()),
    ChangeNotifierProvider(create: (_) => InvoiceDetaiBloc()),
    ChangeNotifierProvider(create: (_) => ComplaintBloc()),
    ChangeNotifierProvider(create: (_) => EpcBloc()),
  ], child: const TMSMobile()));
}


class TMSMobile extends StatelessWidget {
  const TMSMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: languageStreamController.stream,
        builder: (context, snapshot) {
          String localString = '';
          snapshot.data == null
              ? PersistenceData.shared.getLocale() == 'my'
                  ? localString = 'my'
                  : localString = 'en'
              : localString = snapshot.data ?? 'en';
          return MaterialApp(
            title: 'TMS Mobile',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(0.9)),
                child: child!,
              );
            },
            locale: Locale(localString),
            supportedLocales: [Locale('en'), Locale('my')],
            theme: ThemeData(
                fontFamily: AppData.shared.fontFamily,
                colorScheme: ColorScheme.fromSeed(
                    seedColor: kPrimaryColor, primary: kPrimaryColor),
                useMaterial3: true,
                scaffoldBackgroundColor: kBackgroundColor,
                appBarTheme: AppBarTheme(toolbarHeight: kMargin60)),
            home: const SplashScreenPage(),
          );
        });
  }
}
