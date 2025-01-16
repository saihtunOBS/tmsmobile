import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/pages/notification/notification_page.dart';
import 'package:tmsmobile/pages/profile/profile_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../home/home_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index != _currentIndex) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void onBottomNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _tabController.animateTo(index); // Animate tab switch
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [HomePage(), NotificationPage(), ProfilePage()]),
          Container(
            margin: EdgeInsets.only(
                bottom: kMargin24, left: kMargin24, right: kMargin24),
            height: kSize56,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(kMarginMedium),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 6), color: kGreyColor, blurRadius: 10)
                ]),
            child: DefaultTabController(
                length: 3,
                child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.only(
                        top: kMargin52, left: kMargin24, right: kMargin24),
                    indicatorWeight: 4.0,
                    indicator: ShapeDecoration(
                      shape: UnderlineInputBorder(),
                      gradient: LinearGradient(
                        colors: [kPrimaryColor, kThirdColor],
                      ),
                    ),
                    tabs: [
                      Tab(
                        child: _buildHomeTabWidget(),
                      ),
                      Tab(
                        child: _buildNotiTabWidget(),
                      ),
                      Tab(
                        child: _buildProfileTabWidget(),
                      ),
                    ])),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTabWidget() {
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
                  _currentIndex == 0 ? kHomeSelectIcon : kHomeIcon,
                )),
            Positioned(
              top: -10,
              child: AnimatedOpacity(
                opacity: _currentIndex == 0 ? 1 : 0,
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
              color: _currentIndex == 0 ? kPrimaryColor : kBlackColor),
        ),
      ],
    );
  }

  Widget _buildNotiTabWidget() {
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
                    _currentIndex == 1 ? kNotiSelectIcon : kNotiIcon)),
            Positioned(
              top: -10,
              child: AnimatedOpacity(
                opacity: _currentIndex == 1 ? 1 : 0,
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
              color: _currentIndex == 1 ? kPrimaryColor : kBlackColor),
        ),
      ],
    );
  }

  Widget _buildProfileTabWidget() {
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
                    _currentIndex == 2 ? kProfileSelectIcon : kProfileIcon)),
            Positioned(
              top: -10,
              child: AnimatedOpacity(
                opacity: _currentIndex == 2 ? 1 : 0,
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
              color: _currentIndex == 2 ? kPrimaryColor : kBlackColor),
        ),
      ],
    );
  }
}
