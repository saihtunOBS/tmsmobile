import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/service_request_bloc.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/service_request_list_item.dart';
import 'package:tmsmobile/pages/home/fill_out_process_page.dart';
import 'package:tmsmobile/pages/home/maintenance_process_page.dart';
import 'package:tmsmobile/pages/home/maintenance_and_fillout_request_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/widgets/empty_view.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import '../../data/app_data/app_data.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  final fillOutScrollController = ScrollController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index != _currentIndex) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    fillOutScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ServiceRequestBloc(),
      child: Container(
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
                AppLocalizations.of(context)?.kServiceRequestLabel ?? '',
              )),
          body: Consumer<ServiceRequestBloc>(builder: (context, bloc, child) {
            return Stack(children: [
              Column(
                children: [
                  DefaultTabController(
                      length: 2,
                      child: TabBar(
                          dividerColor: Colors.transparent,
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.only(
                              top: kMargin45,
                              left: kMargin24,
                              right: kMargin24),
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
                                      fontSize: AppData.shared.getSmallFontSize(),
                                      fontWeight: FontWeight.w700)),
                            ),
                            Tab(
                              child: Text(
                                kFillOutLabel,
                                style: TextStyle(
                                    fontSize: AppData.shared.getSmallFontSize(),
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ])),
                  Expanded(
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [_buildMaintenanceTab(), _buildFillOutTab()]),
                  ),
                ],
              ),
            ]);
          }),
          floatingActionButton: Consumer<ServiceRequestBloc>(
            builder: (context, bloc, child) => FloatingActionButton(
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
                      .nextPage(
                          page: MaintenanceRequestPage(
                    shops: _currentIndex == 0
                        ? bloc.maintenanceShops
                        : bloc.filloutShops,
                    tenant: _currentIndex == 0
                        ? bloc.maintenanceLists.first.tenant
                        : bloc.fillOutLists.first.tenant,
                    isMaintanence: _currentIndex == 0 ? true : false,
                    issues: bloc.issues,
                  ))
                      .whenComplete(() {
                    bloc.getMaintenances();
                    bloc.getFillOuts();
                  });
                }),
          ),
        ),
      ),
    );
  }

  Widget _buildMaintenanceTab() {
    return Consumer<ServiceRequestBloc>(
      builder: (context, bloc, child) => RefreshIndicator(
        onRefresh: () async => bloc.getMaintenances(),
        child: SizedBox(
          height: double.infinity,
          child: bloc.isLoading == true
              ?

              ///loading
              LoadingView(
                  indicator: Indicator.ballBeat, indicatorColor: kPrimaryColor)
              : bloc.maintenanceLists.isNotEmpty
                  ? SizedBox(
                      height: double.infinity,
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            vertical: kMargin24, horizontal: kMarginMedium2),
                        itemCount: bloc.maintenanceLists.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                PageNavigator(ctx: context).nextPage(
                                    page: MaintenanceProcessPage(
                                  status: '',
                                ));
                              },
                              child: ServiceRequestListItem(
                                data: bloc.maintenanceLists[index],
                                status:
                                    bloc.maintenanceLists[index].status ?? 0,
                              ));
                        },
                      ),
                    )
                  : EmptyView(
                      imagePath: kNoServiceRequestImage,
                      title: AppLocalizations.of(context)
                              ?.kNoServiceRequestLabel ??
                          '',
                      subTitle: AppLocalizations.of(context)
                              ?.kThereisNoServiceRequestLabel ??
                          ''),
        ),
      ),
    );
  }

  Widget _buildFillOutTab() {
    return Consumer<ServiceRequestBloc>(
      builder: (context, bloc, child) => RefreshIndicator(
        onRefresh: () async => bloc.getFillOuts(),
        child: bloc.isLoading == true
            ?

            ///loading
            LoadingView(
                indicator: Indicator.ballBeat, indicatorColor: kPrimaryColor)
            : bloc.fillOutLists.isNotEmpty
                ? SizedBox(
                    height: double.infinity,
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                          left: kMarginMedium2,
                          right: kMarginMedium2,
                          top: kMarginMedium2,
                          bottom: kMargin40 + 10),
                      itemCount: bloc.isLoadMoreFillOut == true
                          ? bloc.fillOutLists.length + 1
                          : bloc.fillOutLists.length,
                      itemBuilder: (context, index) {
                        if (index == bloc.fillOutLists.length) {
                          return LoadingView(
                            bgColor: Colors.transparent,
                            indicator: Indicator.ballBeat,
                            indicatorColor: kPrimaryColor,
                          );
                        }
                        return InkWell(
                          onTap: () => PageNavigator(ctx: context).nextPage(
                              page: FillOutProcessPage(
                            status: kApprovedLabel,
                          )),
                          child: ServiceRequestListItem(
                            status: bloc.fillOutLists[index].status ?? 0,
                            isFillOut: true,
                            data: bloc.fillOutLists[index],
                          ),
                        );
                      },
                      controller: fillOutScrollController
                        ..addListener(() {
                          if (fillOutScrollController.position.pixels ==
                              fillOutScrollController
                                  .position.maxScrollExtent) {
                            bloc.getLoadMoreFillOuts();
                          }
                        }),
                    ),
                  )
                : EmptyView(
                    imagePath: kNoServiceRequestImage,
                    title:
                        AppLocalizations.of(context)?.kNoServiceRequestLabel ??
                            '',
                    subTitle: AppLocalizations.of(context)
                            ?.kThereisNoServiceRequestLabel ??
                        ''),
      ),
    );
  }
}
