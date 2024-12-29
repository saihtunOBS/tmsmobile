import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/complain_list_item.dart';
import 'package:tmsmobile/pages/home/complain_detail_page.dart';
import 'package:tmsmobile/pages/home/submit_complain_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';

import '../../utils/dimens.dart';

class ComplainPage extends StatefulWidget {
  const ComplainPage({super.key});

  @override
  State<ComplainPage> createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kMargin60),
          child: GradientAppBar(
            kCompliantLabel,
          )),
      body: Stack(children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            kBillingBackgroundImage,
            fit: BoxFit.fill,
          ),
        ),
        Column(
          children: [
            DefaultTabController(
                length: 2,
                child: TabBar(
                    dividerColor: Colors.transparent,
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.only(
                        top: kMargin45, left: kMargin24, right: kMargin24),
                    indicatorWeight: 4.0,
                    indicator: ShapeDecoration(
                      shape: UnderlineInputBorder(),
                      gradient: LinearGradient(
                        colors: [kPrimaryColor, kThirdColor],
                      ),
                    ),
                    tabs: [
                      Tab(
                        child: Text(kPendingLabel,
                            style: TextStyle(
                                fontSize: kTextRegular2x,
                                fontWeight: FontWeight.w700)),
                      ),
                      Tab(
                        child: Text(
                          kSolvedLabel,
                          style: TextStyle(
                              fontSize: kTextRegular2x,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ])),
            Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: [_buildPendingTab(), _buildSolvedTab()]),
            ),
          ],
        )
      ]),
      floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: kPrimaryColor,
          child: Center(
            child: Icon(
              Icons.edit,
              color: kWhiteColor,
            ),
          ),
          onPressed: () {
            PageNavigator(ctx: context).nextPage(page: SubmitComplainPage());
          }),
    );
  }

  Widget _buildPendingTab() {
    return ListView.builder(
        padding:
            EdgeInsets.symmetric(vertical: kMargin24, horizontal: kMargin24),
        itemCount: 3,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                PageNavigator(ctx: context).nextPage(
                    page: ComplainDetailPage(
                ));
              },
              child: ComplainListItem(
                isLast: index == 2,
              ));
        });
  }

  Widget _buildSolvedTab() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(
            vertical: kMargin24, horizontal: kMargin24),
        itemCount: 3,
        itemBuilder: (context, index) {
          return ComplainListItem(
            isLast: index == 2,
          );
        });
  }
}
