import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/add_resident_bloc.dart';
import 'package:tmsmobile/bloc/announcement_bloc.dart';
import 'package:tmsmobile/bloc/booking_section_bloc.dart';
import 'package:tmsmobile/bloc/complaint_bloc.dart';
import 'package:tmsmobile/bloc/edit_resident_bloc.dart';
import 'package:tmsmobile/bloc/epc_bloc.dart';
import 'package:tmsmobile/bloc/house_hold_bloc.dart';
import 'package:tmsmobile/bloc/language_bloc.dart';
import 'package:tmsmobile/bloc/notification_bloc.dart';
import 'package:tmsmobile/bloc/owner_nrc_bloc.dart';
import 'package:tmsmobile/bloc/nrc_bloc.dart';
import 'package:tmsmobile/bloc/service_request_bloc.dart';
import 'package:tmsmobile/bloc/tabbar_bloc.dart';
import 'package:tmsmobile/data/app_data/app_data.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/l10n/app_localizations.dart';
import 'package:tmsmobile/network/local_notification_service.dart';
import 'package:tmsmobile/network/notification_service.dart';
import 'package:tmsmobile/pages/auth/splash_screen_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'bloc/invoice_detai_bloc.dart';
import 'firebase_options.dart';
import 'utils/dimens.dart';

import 'utils/route_observer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute> routeObserver = CurrentRouteObserver();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  {
    await Firebase.initializeApp();
  }
  NotificationService().requestPermission();
  LocalNotificationService().initialize();
  await GetStorage.init();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => TabbarBloc()),
    ChangeNotifierProvider(create: (_) => NRCBloc()),
    ChangeNotifierProvider(create: (_) => OwnerNRCBloc()),
    ChangeNotifierProvider(create: (_) => AddResidentBloc()),
    ChangeNotifierProvider(create: (_) => EditResidentBloc()),
    ChangeNotifierProvider(create: (_) => HouseHoldBloc()),
    ChangeNotifierProvider(create: (_) => ServiceRequestBloc()),
    ChangeNotifierProvider(create: (_) => InvoiceDetaiBloc()),
    ChangeNotifierProvider(create: (_) => ComplaintBloc()),
    ChangeNotifierProvider(create: (_) => EpcBloc()),
    ChangeNotifierProvider(create: (_) => AnnouncementBloc()),
    ChangeNotifierProvider(create: (_) => BookingSectionBloc()),
    ChangeNotifierProvider(create: (_) => NotificationBloc()),
  ], child: const TMSMobile()));
}

class TMSMobile extends StatefulWidget {
  const TMSMobile({super.key});

  @override
  State<TMSMobile> createState() => _TMSMobileState();
}

class _TMSMobileState extends State<TMSMobile> {
  @override
  void initState() {
    super.initState();
  }

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
            navigatorKey: navigatorKey,
            navigatorObservers: [routeObserver],
            title: '',
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
            home: SplashScreenPage(),
          );
        });
  }
}
