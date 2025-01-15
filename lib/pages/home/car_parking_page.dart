import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/parking_bloc.dart';
import 'package:tmsmobile/data/vos/contract_information_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/empty_view.dart';

import '../../utils/images.dart';
import '../../widgets/appbar.dart';
import '../../widgets/loading_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CarParkingPage extends StatefulWidget {
  const CarParkingPage({super.key});

  @override
  State<CarParkingPage> createState() => _CarParkingPageState();
}

class _CarParkingPageState extends State<CarParkingPage> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ParkingBloc(),
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
                    AppLocalizations.of(context)?.kCarParkingLabel ?? '')),
            body: Consumer<ParkingBloc>(
              builder: (context, bloc, child) => bloc.isLoading == true
                  ? LoadingView(
                      indicator: Indicator.ballBeat,
                      indicatorColor: kPrimaryColor)
                  : bloc.parkings?.isEmpty ?? true
                      ? EmptyView(
                          imagePath: kNoAnnouncementImage,
                          title: 'No Parking.',
                          subTitle: 'There is no parking right now.')
                      : RefreshIndicator(
                          onRefresh: () async => bloc.getParking(),
                          child: SizedBox(
                            height: double.infinity,
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  vertical: kMarginMedium2,
                                  horizontal: kMarginMedium2 + 2),
                              itemCount: bloc.isLoadMore == true
                                  ? (bloc.parkings?.length ?? 0 + 1)
                                  : bloc.parkings?.length,
                              itemBuilder: (context, index) {
                                if (index == bloc.parkings?.length) {
                                  return LoadingView(
                                      indicator: Indicator.ballBeat,
                                      indicatorColor: kPrimaryColor);
                                }
                                return _buildBody(
                                    bloc.parkings?[index]
                                        as PropertyInformation,
                                    index);
                              },
                              controller: scrollController
                                ..addListener(() {
                                  if (scrollController.position.pixels ==
                                      scrollController
                                          .position.maxScrollExtent) {
                                    bloc.loadMoreData();
                                  }
                                }),
                            ),
                          ),
                        ),
            )),
      ),
    );
  }

  Widget _listItem(
      {required String title,
      required String value,
      bool? isStatus,
      int? status}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: kTextRegular2x),
        ),
        isStatus == true
            ? Container(
                padding: EdgeInsets.symmetric(
                    horizontal: kMargin6, vertical: kMargin6),
                decoration: BoxDecoration(
                    color:
                        filterStatusColor(status ?? 0).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(kMarginMedium2)),
                child: Center(
                  child: FittedBox(
                      child: Text(
                    value,
                    style: TextStyle(
                        color: filterStatusColor(status ?? 0),
                        fontSize: kTextSmall),
                  )),
                ),
              )
            : Text(
                value,
                style: TextStyle(
                    fontSize: kTextRegular2x, fontWeight: FontWeight.w700),
              ),
      ],
    );
  }

  String filterStatus(int status) {
    switch (status) {
      case 1:
        return 'Available';
      case 2:
        return 'Unavailable';
      default:
        return 'Available';
    }
  }

  Color filterStatusColor(int status) {
    switch (status) {
      case 1:
        return kGreenColor;
      case 2:
        return kRedColor;
      default:
        return kRedColor;
    }
  }

  Widget _buildBody(PropertyInformation data, int index) {
    return Consumer<ParkingBloc>(
      builder: (context, bloc, child) => Container(
        margin: EdgeInsets.only(bottom: kMarginMedium2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMargin10),
          boxShadow: [
            BoxShadow(
                offset: Offset(
                  0,
                  4,
                ),
                blurRadius: 10,
                color: const Color.fromARGB(255, 207, 205, 205))
          ],
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: kMarginSmallx),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kMargin10),
            gradient: LinearGradient(
              colors: [kPrimaryColor, kThirdColor],
              stops: [0.0, 1.0],
            ),
          ),
          child: ExpansionTile(
            showTrailingIcon: false,
            shape: Border(),
            collapsedShape: Border(),
            expansionAnimationStyle:
                AnimationStyle(duration: Duration(milliseconds: 10)),
            key: Key(bloc.selectedExpensionIndex.toString()),
            initiallyExpanded: bloc.selectedExpensionIndex == index,
            onExpansionChanged: (isExpanded) {
              if (isExpanded) {
                bloc.selectedExpensionIndex = index;
              } else {
                bloc.selectedExpensionIndex = -1;
              }
              bloc.onTapExpansion();
            },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.kParkingCodeLabel ?? '',
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: kTextRegular13,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '#${data.shop?.parkingData?.first.parkingCode?.parkingCode}',
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: kTextRegular2x,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: kMargin10, horizontal: kMargin10),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Column(
                  spacing: kMargin10,
                  children: [
                    _listItem(
                        title: AppLocalizations.of(context)?.kBranchLabel ?? '',
                        value: data.branch?.name ?? ''),
                    _listItem(
                        title:
                            AppLocalizations.of(context)?.kBuildingLabel ?? '',
                        value: data.building?.name ?? ''),
                    _listItem(
                        title: AppLocalizations.of(context)?.kFloorLabel ?? '',
                        value: data.floor?.name ?? ''),
                    _listItem(
                        title:
                            AppLocalizations.of(context)?.kZoneViewLabel ?? '',
                        value: data.zone?.name ?? ''),
                    _listItem(
                        title:
                            AppLocalizations.of(context)?.kParkingCodeLabel ??
                                '',
                        value:
                            '#${data.shop?.parkingData?.first.parkingCode?.parkingCode}'),
                    _listItem(
                        title: AppLocalizations.of(context)?.kStatusLabel ?? '',
                        value: filterStatus(data.shop?.status ?? 0),
                        isStatus: true),
                    _listItem(
                        title:
                            AppLocalizations.of(context)?.kVehicleNoLabel ?? '',
                        value: '0001'),
                    5.vGap,
                    // _buildParkingInformation(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildParkingInformation() {
  //   return ListTileTheme(
  //     dense: true,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(kMargin5),
  //         gradient: LinearGradient(
  //           colors: [kPrimaryColor, kThirdColor],
  //           stops: [0.0, 1.0],
  //         ),
  //       ),
  //       child: ExpansionTile(
  //         shape: Border(),
  //         expansionAnimationStyle:
  //             AnimationStyle(duration: Duration(milliseconds: 10)),
  //         collapsedShape: Border(),
  //         iconColor: kWhiteColor,
  //         collapsedIconColor: kWhiteColor,
  //         title: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           spacing: kMargin10,
  //           children: [
  //             Icon(
  //               CupertinoIcons.car_detailed,
  //               color: kWhiteColor,
  //             ),
  //             Text(
  //               kParkingInformationLabel,
  //               style: TextStyle(
  //                   color: kWhiteColor,
  //                   fontSize: kTextRegular2x,
  //                   fontWeight: FontWeight.w700),
  //             ),
  //           ],
  //         ),
  //         children: [
  //           Container(
  //             padding: EdgeInsets.symmetric(vertical: kMargin10),
  //             decoration: BoxDecoration(
  //               color: kWhiteColor,
  //             ),
  //             child: Column(
  //               spacing: kMargin10,
  //               children: [
  //                 _listItem(title: kBranchLabel, value: 'value'),
  //                 _listItem(title: kBuildingLabel, value: 'value'),
  //                 _listItem(title: kFloorLabel, value: 'value'),
  //                 _listItem(title: kZoneViewLabel, value: 'value'),
  //                 _listItem(title: kRoomTypeLabel, value: 'value'),
  //                 _listItem(title: kRoomShopNameLabel, value: 'value'),
  //                 _listItem(title: kTotalAreaLabel, value: 'value'),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
