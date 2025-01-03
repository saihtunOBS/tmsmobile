import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/service_request_list_item.dart';
import 'package:tmsmobile/pages/home/fill_out_process_page.dart';
import 'package:tmsmobile/pages/home/maintenance_process_page.dart';
import 'package:tmsmobile/pages/home/maintenance_request_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';

import '../../utils/dimens.dart';

class ServiceRequestPage extends StatefulWidget {
  const ServiceRequestPage({super.key});

  @override
  State<ServiceRequestPage> createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage>
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        image: DecorationImage(
            image: AssetImage(kBillingBackgroundImage), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kMargin60),
            child: GradientAppBar(
              kServiceRequestLabel,
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
                          child: Text(kMaintenanceLabel,
                              style: TextStyle(
                                  fontSize: kTextRegular2x,
                                  fontWeight: FontWeight.w700)),
                        ),
                        Tab(
                          child: Text(
                            kFillOutLabel,
                            style: TextStyle(
                                fontSize: kTextRegular2x,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ])),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children: [_buildMaintenanceTab(), _buildFillOutTab()]),
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
              PageNavigator(ctx: context)
                  .nextPage(page: MaintenanceRequestPage());
            }),
      ),
    );
  }

  Widget _buildMaintenanceTab() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(
            vertical: kMargin24, horizontal: kMarginMedium2),
        itemCount: 3,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                // PageNavigator(ctx: context)
                //     .nextPage(page: MaintenanceProcessPage(status: '',));
              },
              child: ServiceRequestListItem(statusColor: 0, status: 'Pending'));
        });
  }

  Widget _buildFillOutTab() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(
            vertical: kMargin24, horizontal: kMarginMedium2),
        itemCount: 3,
        itemBuilder: (context, index) {
          return InkWell(
            // onTap: ()=> PageNavigator(ctx: context)
            //         .nextPage(page: FillOutProcessPage(status: kApprovedLabel,)),
            child: ServiceRequestListItem(
              statusColor: 0,
              status: 'Pending',
              isFillOut: true,
            ),
          );
        });
  }
}
