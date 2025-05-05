import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final maintenanceScrollController = ScrollController();

  @override
  void initState() {
    var bloc = context.read<ServiceRequestBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.updateToken();
      bloc.getMaintenances();
    });
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index != _currentIndex) {
        setState(() {
          _currentIndex = _tabController.index;
        });

        if (_currentIndex == 0) {
          bloc.getMaintenances();
        } else {
          bloc.getFillOuts();
        }
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
              AppLocalizations.of(context)?.kServiceRequestLabel ?? '',
            )),
        body: Consumer<ServiceRequestBloc>(builder: (context, bloc, child) {
          return Stack(children: [
            Column(
              children: [
                DefaultTabController(
                    length: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: kMargin24),
                      child: TabBar(
                          dividerColor: kGreyColor,
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.only(
                            top: kMargin45,
                          ),
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
                                      fontSize: kTextRegular,
                                      fontWeight: FontWeight.w700)),
                            ),
                            Tab(
                              child: Text(
                                AppLocalizations.of(context)?.kFillOutLabel ??
                                    '',
                                style: TextStyle(
                                    fontSize: kTextRegular,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ]),
                    )),
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
                        page: MaintenanceAndFillOutRequestPage(
                  isMaintanence: _currentIndex == 0 ? true : false,
                ))
                    .whenComplete(() {
                  bloc.getMaintenances();
                  bloc.getFillOuts();
                });
              }),
        ),
      ),
    );
  }

  Widget _buildMaintenanceTab() {
    return Consumer<ServiceRequestBloc>(
      builder: (context, bloc, child) => RefreshIndicator(
        backgroundColor: kBackgroundColor,
        elevation: 0.0,
        onRefresh: () async {
          HapticFeedback.mediumImpact();
          bloc.getMaintenances();
        },
        child: SizedBox(
          height: double.infinity,
          child: bloc.isLoading == true
              ?

              ///loading
              LoadingView()
              : bloc.maintenanceLists.isNotEmpty
                  ? SizedBox(
                      height: double.infinity,
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            vertical: kMargin24, horizontal: kMargin24),
                        itemCount: bloc.isLoadMoreMaintenance == true
                            ? bloc.maintenanceLists.length + 1
                            : bloc.maintenanceLists.length,
                        itemBuilder: (context, index) {
                          if (index == bloc.maintenanceLists.length) {
                            return LoadingView(
                              bgColor: Colors.transparent,
                            );
                          }
                          return GestureDetector(
                              onTap: () {
                                PageNavigator(ctx: context)
                                    .nextPage(
                                        page: MaintenanceProcessPage(
                                  status:
                                      bloc.maintenanceLists[index].status ?? 0,
                                  id: bloc.maintenanceLists[index].id,
                                  data: bloc.maintenanceLists[index],
                                ))
                                    .whenComplete(() {
                                  bloc.getMaintenances();
                                });
                              },
                              child: ServiceRequestListItem(
                                data: bloc.maintenanceLists[index],
                                status:
                                    bloc.maintenanceLists[index].status ?? 0,
                              ));
                        },
                        controller: maintenanceScrollController
                          ..addListener(() {
                            if (maintenanceScrollController.position.pixels ==
                                maintenanceScrollController
                                    .position.maxScrollExtent) {
                              if (bloc.maintenanceLists.length < 10) return;
                              bloc.getLoadMoreMaintenance();
                            }
                          }),
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
        backgroundColor: kBackgroundColor,
        elevation: 0.0,
        onRefresh: () async {
          HapticFeedback.mediumImpact();
          bloc.getFillOuts();
        },
        child: bloc.isLoading == true
            ?

            ///loading
            LoadingView()
            : bloc.fillOutLists.isNotEmpty
                ? SizedBox(
                    height: double.infinity,
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          vertical: kMargin24, horizontal: kMargin24),
                      itemCount: bloc.isLoadMoreFillOut == true
                          ? bloc.fillOutLists.length + 1
                          : bloc.fillOutLists.length,
                      itemBuilder: (context, index) {
                        if (index == bloc.fillOutLists.length) {
                          return LoadingView(
                            bgColor: Colors.transparent,
                          );
                        }
                        return GestureDetector(
                          onTap: () => PageNavigator(ctx: context)
                              .nextPage(
                                  page: FillOutProcessPage(
                            status: bloc.fillOutLists[index].status ?? 0,
                            id: bloc.fillOutLists[index].id ?? '',
                            fillOutData: bloc.fillOutLists[index],
                          ))
                              .whenComplete(() {
                            bloc.getFillOuts();
                          }),
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
                            if (bloc.fillOutLists.length < 10) return;
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
