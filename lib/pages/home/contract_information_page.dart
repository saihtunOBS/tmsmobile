import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/contract_information_bloc.dart';
import 'package:tmsmobile/data/vos/contract_information_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/loading_view.dart';

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
            child: GradientAppBar(kContractInformationLabel)),
        body: Selector<ContractInformationBloc, bool?>(
          selector: (p0, p1) => p1.isLoading,
          builder: (context, isLoading, child) => isLoading == true
              ? LoadingView(
                  indicator: Indicator.ballBeat, indicatorColor: kPrimaryColor)
              : Consumer<ContractInformationBloc>(
                  builder: (context, bloc, child) => SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildHeader(bloc.contract as ContractInformationVO),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                vertical: kMarginMedium2,
                                horizontal: kMarginMedium2 + 2),
                            itemCount:
                                bloc.contract?.propertyInformation?.length,
                            itemBuilder: (context, index) {
                              return _buildBody(
                                  bloc.contract?.propertyInformation?[index]
                                      as PropertyInformation);
                            })
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildHeader(ContractInformationVO data) {
    return Container(
      margin:
          EdgeInsets.only(left: kMargin24, right: kMargin24, top: kMargin24),
      child: Column(
        spacing: kMarginMedium14,
        children: [
          _listItem(title: kCreatedDateLabel, value: '12/21/2025'),
          _listItem(title: kTenantTypeLabel, value: type),
          _listItem(
              title: kTenantCategoryLabel,
              value: data.tenant?.tenantCategory?.tenantCategoryName ?? ''),
          _listItem(title: kStartDateLabel, value: '12/21/2025'),
          _listItem(title: kEndDateLabel, value: '12/21/2025'),
          Divider(
            thickness: 0.5,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget _listItem({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: kTextRegular2x),
        ),
        Text(
          value,
          style:
              TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildBody(PropertyInformation data) {
    return Container(
      margin: EdgeInsets.only(bottom: kMarginMedium2 + 4),
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
          expansionAnimationStyle:
              AnimationStyle(duration: Duration(milliseconds: 10)),
          collapsedShape: Border(),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kRoomShopNameLabel,
                style: TextStyle(
                    color: kWhiteColor,
                    fontSize: kTextRegular13,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                '#${data.shop?.name}',
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
                children: [
                  _listItem(
                      title: kBranchLabel, value: data.branch?.name ?? ''),
                  10.vGap,
                  _listItem(
                      title: kBuildingLabel, value: data.building?.name ?? ''),
                  10.vGap,
                  _listItem(title: kFloorLabel, value: data.floor?.name ?? ''),
                  10.vGap,
                  _listItem(
                      title: kZoneViewLabel, value: data.zone?.name ?? ''),
                  10.vGap,
                  _listItem(
                      title: kRoomTypeLabel,
                      value: data.roomType?.roomType ?? ''),
                  10.vGap,
                  _listItem(
                      title: kRoomShopNameLabel,
                      value: '#${data.shop?.name ?? ''}'),
                  10.vGap,
                  _listItem(
                      title: kTotalAreaLabel,
                      value: '${data.totalArea ?? ''} sq ft'),
                  10.vGap,
                  data.parkingInformation?.isNotEmpty ?? true
                      ? _buildParkingInformation()
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParkingInformation() {
    return ListTileTheme(
      dense: true,
      child: Container(
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
                    fontSize: kTextRegular2x,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: kMargin10),
              decoration: BoxDecoration(
                color: kWhiteColor,
              ),
              child: Column(
                spacing: kMargin10,
                children: [
                  _listItem(title: kBranchLabel, value: 'value'),
                  _listItem(title: kBuildingLabel, value: 'value'),
                  _listItem(title: kFloorLabel, value: 'value'),
                  _listItem(title: kZoneViewLabel, value: 'value'),
                  _listItem(title: kRoomTypeLabel, value: 'value'),
                  _listItem(title: kRoomShopNameLabel, value: 'value'),
                  _listItem(title: kTotalAreaLabel, value: 'value'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
