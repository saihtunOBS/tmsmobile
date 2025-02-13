import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/contract_information_bloc.dart';
import 'package:tmsmobile/data/vos/contract_information_vo.dart';
import 'package:tmsmobile/data/vos/parking_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/strings.dart';
import '../../widgets/appbar.dart';

class ContractInformationPage extends StatelessWidget {
  const ContractInformationPage(
      {super.key, required this.id, required this.type});
  final String id;
  final String type;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContractInformationBloc(id),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kMargin60),
            child: GradientAppBar(
                AppLocalizations.of(context)?.kContractInformationLabel ?? '')),
        body: Selector<ContractInformationBloc, bool?>(
          selector: (p0, p1) => p1.isLoading,
          builder: (context, isLoading, child) => isLoading == true
              ? LoadingView()
              : Consumer<ContractInformationBloc>(
                  builder: (context, bloc, child) => SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildHeader(
                            bloc.contract ?? ContractInformationVO(), context),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                vertical: kMarginMedium,
                                horizontal: kMarginMedium2 + 2),
                            itemCount:
                                bloc.contract?.propertyInformation?.length,
                            itemBuilder: (context, index) {
                              return _buildBody(
                                  bloc.contract?.propertyInformation?[index] ??
                                      PropertyInformation(),
                                  index);
                            })
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildHeader(ContractInformationVO data, BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: kMargin24, right: kMargin24, top: kMargin24),
      child: Column(
        spacing: kMarginMedium14,
        children: [
          _listItem(
              title: AppLocalizations.of(context)?.kCreatedDateLabel ?? '',
              value: '12/21/2025'),
          _listItem(
              title: AppLocalizations.of(context)?.kTenantTypeLabel ?? '',
              value: type),
          _listItem(
              title: AppLocalizations.of(context)?.kTenantCategoryLabel ?? '',
              value: data.tenant?.tenantCategory?.tenantCategoryName ?? ''),
          Visibility(
            visible: type == 'lease',
            child: Column(
              spacing: kMarginMedium14,
              children: [
                _listItem(
                    title: AppLocalizations.of(context)?.kStartDateLabel ?? '',
                    value: '12/21/2025'),
                _listItem(
                    title: AppLocalizations.of(context)?.kEndDateLabel ?? '',
                    value: '12/21/2025'),
              ],
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Colors.black,
          )
        ],
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
          style: TextStyle(fontSize: kTextRegular),
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
                    fontSize: kTextRegular,
                    fontWeight: FontWeight.w700),
              ),
      ],
    );
  }

  Widget _buildBody(PropertyInformation data, int index) {
    return Consumer<ContractInformationBloc>(
      builder: (context, bloc, child) => Container(
        margin: EdgeInsets.only(bottom: kMargin10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMargin10),
          boxShadow: [
            BoxShadow(
                offset: Offset(
                  0,
                  3,
                ),
                blurRadius: 5,
                color: const Color.fromARGB(255, 221, 219, 219))
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
            expansionAnimationStyle:
                AnimationStyle(duration: Duration(milliseconds: 10)),
            collapsedShape: Border(),
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
                  AppLocalizations.of(context)?.kRoomShopNameLabel ?? '',
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: kTextRegular13,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '#${data.shop?.name}',
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: kTextRegular,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: kMargin10, horizontal: kMargin10 + 5),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Column(
                  children: [
                    _listItem(
                        title: AppLocalizations.of(context)?.kBranchLabel ?? '',
                        value: data.branch?.name ?? ''),
                    10.vGap,
                    _listItem(
                        title:
                            AppLocalizations.of(context)?.kBuildingLabel ?? '',
                        value: data.building?.name ?? ''),
                    10.vGap,
                    _listItem(
                        title: AppLocalizations.of(context)?.kFloorLabel ?? '',
                        value: data.floor?.name ?? ''),
                    10.vGap,
                    _listItem(
                        title:
                            AppLocalizations.of(context)?.kZoneViewLabel ?? '',
                        value: data.zone?.name ?? ''),
                    10.vGap,
                    _listItem(
                        title:
                            AppLocalizations.of(context)?.kRoomTypeLabel ?? '',
                        value: data.roomType?.roomType ?? ''),
                    10.vGap,
                    _listItem(
                        title:
                            AppLocalizations.of(context)?.kRoomShopNameLabel ??
                                '',
                        value: '#${data.shop?.name ?? ''}'),
                    10.vGap,
                    _listItem(
                        title:
                            AppLocalizations.of(context)?.kTotalAreaLabel ?? '',
                        value: '${data.totalArea ?? ''} sq ft'),
                    data.shop?.parkingData?.isNotEmpty ?? true
                        ? 5.vGap
                        : 0.vGap,
                    data.shop?.parkingData?.isNotEmpty ?? true
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.shop?.parkingData?.length,
                            itemBuilder: (context, index) {
                              return _buildParkingInformation(
                                  data.shop?.parkingData?[index] ??
                                      ParkingVO(),
                                  data,
                                  context,
                                  bloc,
                                  index);
                            })
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParkingInformation(
      ParkingVO parkingData,
      PropertyInformation data,
      BuildContext context,
      ContractInformationBloc bloc,
      int index) {
    return ListTileTheme(
      dense: true,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMargin5),
          gradient: LinearGradient(
            colors: [kPrimaryColor, kThirdColor],
            stops: [0.0, 1.0],
          ),
        ),
        child: ExpansionTile(
          expansionAnimationStyle:
              AnimationStyle(duration: Duration(milliseconds: 10)),
          key: Key(bloc.selectedParkingExpensionIndex.toString()),
          initiallyExpanded: bloc.selectedParkingExpensionIndex == index,
          onExpansionChanged: (isExpanded) {
            if (isExpanded) {
              bloc.selectedParkingExpensionIndex = index;
            } else {
              bloc.selectedParkingExpensionIndex = -1;
            }
            bloc.onTapExpansion();
          },
          shape: Border(),
          collapsedShape: Border(),
          iconColor: kWhiteColor,
          collapsedIconColor: kWhiteColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: kMargin10,
            children: [
              Icon(
                CupertinoIcons.car_detailed,
                color: kWhiteColor,
              ),
              Text(
                kParkingInformationLabel,
                style: TextStyle(
                    color: kWhiteColor,
                    fontSize: kTextRegular,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          children: [
            Container(
              padding: EdgeInsets.only(top: kMargin10, bottom: 5),
              decoration: BoxDecoration(
                color: kWhiteColor,
              ),
              child: Column(
                spacing: kMargin10,
                children: [
                  _listItem(
                      title: AppLocalizations.of(context)?.kBranchLabel ?? '',
                      value: data.branch?.name ?? ''),
                  _listItem(
                      title: AppLocalizations.of(context)?.kBuildingLabel ?? '',
                      value: data.building?.name ?? ''),
                  _listItem(
                      title: AppLocalizations.of(context)?.kFloorLabel ?? '',
                      value: data.floor?.name ?? ''),
                  _listItem(
                      title: AppLocalizations.of(context)?.kZoneViewLabel ?? '',
                      value: data.zone?.name ?? ''),
                  _listItem(
                      title:
                          AppLocalizations.of(context)?.kParkingCodeLabel ?? '',
                      value: parkingData.parkingCode?.parkingCode ?? ''),
                  _listItem(
                      title: AppLocalizations.of(context)?.kStatusLabel ?? '',
                      value: filterStatus(data.shop?.status ?? 0),
                      isStatus: true),
                  _listItem(
                      title:
                          AppLocalizations.of(context)?.kVehicleNoLabel ?? '',
                      value: '0002'),
                ],
              ),
            ),
          ],
        ),
      ),
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
}
