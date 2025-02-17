import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/tabbar_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/pages/notification/notification_page.dart';
import 'package:tmsmobile/pages/profile/profile_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tmsmobile/widgets/connection_alert.dart';

import '../../bloc/check_connection_bloc.dart';
import '../home/home_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CheckConnectionBloc _connectionBloc = CheckConnectionBloc();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _connectionBloc.connectionStream,
        builder: (context, snapshot) {
          if (snapshot.data == ConnectivityResult.none) {
            showConnectionError(context);
            Future.delayed(Duration(seconds: 3), () {
              if (mounted) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
              }
            });
          } else {}
          return ChangeNotifierProvider(
            create: (context) => TabbarBloc(context: context),
            child: Consumer<TabbarBloc>(
              builder: (context, bloc, child) => Scaffold(
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    IndexedStack(
                      index: bloc.currentIndex,
                      children: [HomePage(), NotificationPage(), ProfilePage()],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: kMargin24,
                          left: kMarginMedium2,
                          right: kMarginMedium2),
                      height: kSize56,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(kMarginMedium),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 2),
                                color: kGreyColor,
                                blurRadius: 5)
                          ]),
                      child: DefaultTabController(
                          length: 3,
                          child: TabBar(
                              controller: _tabController,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorPadding: EdgeInsets.only(
                                  top: kMargin52,
                                  left: kMargin24,
                                  right: kMargin24),
                              indicatorWeight: 4.0,
                              indicator: ShapeDecoration(
                                shape: UnderlineInputBorder(),
                                gradient: LinearGradient(
                                  colors: [kPrimaryColor, kThirdColor],
                                ),
                              ),
                              onTap: (value) => bloc.changeIndex(value),
                              dividerHeight: 0.0,
                              tabs: [
                                Tab(
                                  child: _buildHomeTabWidget(bloc),
                                ),
                                Tab(
                                  child: _buildNotiTabWidget(bloc),
                                ),
                                Tab(
                                  child: _buildProfileTabWidget(bloc),
                                ),
                              ])),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildHomeTabWidget(TabbarBloc bloc) {
    return Column(
      children: [
        3.vGap,
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
                height: kMargin24,
                width: kMargin24,
                child: Image.asset(
                  bloc.currentIndex == 0 ? kHomeSelectIcon : kHomeIcon,
                )),
            Positioned(
              top: -10,
              child: AnimatedOpacity(
                opacity: bloc.currentIndex == 0 ? 1 : 0,
                duration: Duration(milliseconds: 200),
                child: Image.asset(
                  kStarLogo,
                  width: kMargin24 + 1,
                  height: kMargin24,
                ),
              ),
            )
          ],
        ),
        Text(
          AppLocalizations.of(context)?.kHomeLabel ?? '',
          style: TextStyle(
              fontSize: kTextSmall,
              fontWeight: FontWeight.w600,
              color: bloc.currentIndex == 0 ? kPrimaryColor : kBlackColor),
        ),
      ],
    );
  }

  Widget _buildNotiTabWidget(TabbarBloc bloc) {
    return Column(
      children: [
        3.vGap,
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
                height: kMargin24,
                width: kMargin24,
                child: Image.asset(
                    bloc.currentIndex == 1 ? kNotiSelectIcon : kNotiIcon)),
            Positioned(
              top: -10,
              child: AnimatedOpacity(
                opacity: bloc.currentIndex == 1 ? 1 : 0,
                duration: Duration(milliseconds: 200),
                child: Image.asset(
                  kStarLogo,
                  width: kMargin24 + 1,
                  height: kMargin24,
                ),
              ),
            )
          ],
        ),
        Text(
          AppLocalizations.of(context)?.kNotiLabel ?? '',
          style: TextStyle(
              fontSize: kTextSmall,
              fontWeight: FontWeight.w600,
              color: bloc.currentIndex == 1 ? kPrimaryColor : kBlackColor),
        ),
      ],
    );
  }

  Widget _buildProfileTabWidget(TabbarBloc bloc) {
    return Column(
      children: [
        3.vGap,
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
                height: kMargin24,
                width: kMargin24,
                child: Image.asset(bloc.currentIndex == 2
                    ? kProfileSelectIcon
                    : kProfileIcon)),
            Positioned(
              top: -10,
              child: AnimatedOpacity(
                opacity: bloc.currentIndex == 2 ? 1 : 0,
                duration: Duration(milliseconds: 200),
                child: Image.asset(
                  kStarLogo,
                  width: kMargin24 + 1,
                  height: kMargin24,
                ),
              ),
            )
          ],
        ),
        Text(
          AppLocalizations.of(context)?.kProfileLabel ?? '',
          style: TextStyle(
              fontSize: kTextSmall,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
              color: bloc.currentIndex == 2 ? kPrimaryColor : kBlackColor),
        ),
      ],
    );
  }
}
