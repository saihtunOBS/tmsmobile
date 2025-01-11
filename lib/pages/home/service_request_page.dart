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

  final scrollController = ScrollController();

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
    scrollController.dispose();
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
                kServiceRequestLabel,
              )),
          body: Consumer<ServiceRequestBloc>(
            builder: (context, bloc, child) => Stack(children: [
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
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          _buildMaintenanceTab(),
                          _buildFillOutTab(bloc)
                        ]),
                  ),
                ],
              ),
            ]),
          ),
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
                        shops: bloc.shops,
                        tenant: bloc.fillOutLists.first.tenant,
                        isMaintanence: _currentIndex == 0 ? true : false,
                      ))
                      .whenComplete(() => bloc.getFillOuts());
                }),
          ),
        ),
      ),
    );
  }

  Widget _buildMaintenanceTab() {
    return Consumer<ServiceRequestBloc>(
      builder: (context, bloc, child) => bloc.isLoading == true
          ?

          ///loading
          LoadingView(
              indicator: Indicator.ballBeat, indicatorColor: kPrimaryColor)
          : RefreshIndicator(
              onRefresh: () async => bloc.fillOutLists.clear(),
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification &&
                      scrollController.position.extentAfter == 0) {
                    var bloc = context.read<ServiceRequestBloc>();
                    bloc.getLoadMoreFillOuts();
                  }
                  return false;
                },
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        vertical: kMargin24, horizontal: kMarginMedium2),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            PageNavigator(ctx: context).nextPage(
                                page: MaintenanceProcessPage(
                              status: '',
                            ));
                          },
                          child: ServiceRequestListItem(
                              statusColor: 0, status: 'Pending'));
                    }),
              ),
            ),
    );
  }

  Widget _buildFillOutTab(ServiceRequestBloc bloc) {
    return bloc.isLoading == true
        ?

        ///loading
        LoadingView(
            indicator: Indicator.ballBeat, indicatorColor: kPrimaryColor)
        : RefreshIndicator(
            onRefresh: () async => bloc.getFillOuts(),
            child: bloc.fillOutLists.isEmpty
                ? EmptyView(
                    imagePath: kNoServiceRequestImage,
                    title: kNoServiceRequestLabel,
                    subTitle: kThereisNoServiceRequestLabel)
                : NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollEndNotification &&
                          scrollController.position.extentAfter == 0) {
                        if (!bloc.isLoadMore) {
                          bloc.getLoadMoreFillOuts();
                        }
                      }
                      return false;
                    },
                    child: ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.only(
                            left: kMarginMedium2,
                            right: kMarginMedium2,
                            top: kMarginMedium2,
                            bottom: kMargin40),
                        itemCount: bloc.isLoadMore == true
                            ? bloc.fillOutLists.length + 1
                            : bloc.fillOutLists.length,
                        itemBuilder: (context, index) {
                          if (index == bloc.fillOutLists.length &&
                              bloc.isLoadMore) {
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
                              statusColor: bloc.fillOutLists[index].status ?? 0,
                              status: 'Pending',
                              isFillOut: true,
                              data: bloc.fillOutLists[index],
                            ),
                          );
                        }),
                  ),
          );
  }
}
