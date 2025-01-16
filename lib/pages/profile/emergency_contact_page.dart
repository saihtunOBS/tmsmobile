import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/emergency_bloc.dart';
import 'package:tmsmobile/data/vos/emergency_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/widgets/empty_view.dart';

import '../../data/app_data/app_data.dart';
import '../../utils/images.dart';
import '../../widgets/loading_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EmergencyContactPage extends StatefulWidget {
  const EmergencyContactPage({super.key});

  @override
  State<EmergencyContactPage> createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmergencyBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Consumer<EmergencyBloc>(
          builder: (context, bloc, child) => Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  kBillingBackgroundImage,
                  fit: BoxFit.fill,
                ),
              ),
              bloc.isLoading == true
                  ? LoadingView(
                      indicator: Indicator.ballBeat,
                      indicatorColor: kPrimaryColor)
                  : bloc.emergencyLists?.isEmpty ?? true
                      ? EmptyView(
                          imagePath: kNoAnnouncementImage,
                          title: 'No Emergency contacts.',
                          subTitle: 'There is no emergency contact right now.')
                      : Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1,
                              left: kMarginMedium2,
                              right: kMarginMedium2,
                              bottom: kMarginMedium2),
                          child: RefreshIndicator(
                            onRefresh: () async => bloc.getEmergency(),
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: bloc.isLoadMore == true
                                  ? bloc.emergencyLists?.length ?? 0 + 1
                                  : bloc.emergencyLists?.length,
                              itemBuilder: (context, index) {
                                if (index == bloc.emergencyLists?.length) {
                                  return LoadingView(
                                      indicator: Indicator.ballBeat,
                                      indicatorColor: kPrimaryColor);
                                }
                                return _buildListItem(
                                    data: bloc.emergencyLists?[index],
                                    index: index,
                                    title: bloc
                                        .emergencyLists?[index].contractName);
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
                          )),

              ///appbar
              Positioned(
                  top: 0,
                  child: ProfileAppbar(
                    title: AppLocalizations.of(context)?.kEmergencyContactLabel,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listItem(
      {required String title, required String value, bool? isNumber}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: kMargin5,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: AppData.shared.getSmallFontSize()),
        ),
        Text(
          value,
          style: TextStyle(
              color: isNumber == true ? kBlueColor : kBlackColor,
              fontSize: AppData.shared.getRegularFontSize(),
              fontWeight: FontWeight.w700,
              decoration: isNumber == true ? TextDecoration.underline : null,
              decorationColor: kBlueColor,
              decorationThickness: 3.0),
        ),
      ],
    );
  }

  Widget _buildListItem({String? title, int? index, EmergencyVO? data}) {
    return Consumer<EmergencyBloc>(
      builder: (context, bloc, child) => Container(
        margin: EdgeInsets.only(bottom: kMargin10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
            key: Key(bloc.selectedExpensionIndex.toString()),
            initiallyExpanded: bloc.selectedExpensionIndex == index,
            onExpansionChanged: (isExpanded) {
              if (isExpanded) {
                bloc.selectedExpensionIndex = index ?? 0;
              } else {
                bloc.selectedExpensionIndex = -1;
              }
              bloc.onTapExpansion();
            },
            shape: Border(),
            collapsedShape: Border(),
            title: Text(
              title ?? '',
              style: TextStyle(
                  color: kWhiteColor,
                  fontSize: AppData.shared.getSmallFontSize(),
                  fontWeight: FontWeight.w700),
            ),
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: kMargin10, horizontal: kMargin10),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: kMargin12,
                  children: [
                    _listItem(
                        title: AppLocalizations.of(context)?.kContactNameLabel ?? '',
                        value: data?.emergencyCategory?.name ?? ''),
                    _listItem(title: AppLocalizations.of(context)?.kAddressLabel ?? '', value: data?.address ?? ''),
                    InkWell(
                      onTap: () => makePhoneCall(data?.phone1 ?? ''),
                      child: _listItem(
                          title: '${AppLocalizations.of(context)?.kTelephoneNormalLabel} (Office Hours)',
                          value: data?.phone1 ?? '',
                          isNumber: true),
                    ),
                    InkWell(
                      onTap: () => makePhoneCall(data?.phone2 ?? ''),
                      child: _listItem(
                          title: AppLocalizations.of(context)?.kTelephoneNormal24Label ?? '',
                          value: data?.phone2 ?? '',
                          isNumber: true),
                    ),
                    _listItem(
                        title: AppLocalizations.of(context)?.kContractRefLabel ?? '',
                        value: data?.contractRef ?? ''),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
