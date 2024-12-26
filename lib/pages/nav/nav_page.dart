import 'package:flutter/material.dart';
import 'package:tmsmobile/pages/notification/notification_page.dart';
import 'package:tmsmobile/pages/profile/profile_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/utils/strings.dart';

import '../home/home_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

int _currentIndex = 0;
late TabController _tabController;

class _NavPageState extends State<NavPage> with SingleTickerProviderStateMixin {
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
      backgroundColor: kBackgroundColor,
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [HomePage(), NotificationPage(), ProfilePage()]),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            right: kMargin24, left: kMargin24, bottom: kMargin24),
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kMarginMedium),
            boxShadow: [
              BoxShadow(offset: Offset(0, 5), color: kGreyColor, blurRadius: 10)
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
    );
  }

  Widget _buildHomeTabWidget() {
    return Column(
      children: [
        SizedBox(
            height: kMargin24,
            width: kMargin24,
            child:
                Image.asset(_currentIndex == 0 ? kHomeSelectIcon : kHomeIcon)),
        Text(kHomeLabel),
      ],
    );
  }

  Widget _buildNotiTabWidget() {
    return Column(
      children: [
        SizedBox(
            height: kMargin24,
            width: kMargin24,
            child:
                Image.asset(_currentIndex == 1 ? kNotiSelectIcon : kNotiIcon)),
        Text(kNotiLabel),
      ],
    );
  }

  Widget _buildProfileTabWidget() {
    return Column(
      children: [
        SizedBox(
            height: kMargin24,
            width: kMargin24,
            child: Image.asset(
                _currentIndex == 2 ? kProfileSelectIcon : kProfileIcon)),
        Text(kProfileLabel),
      ],
    );
  }
}
