import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/emergency_bloc.dart';
import 'package:tmsmobile/data/vos/emergency_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/widgets/empty_view.dart';

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
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  kBillingBackgroundImage,
                  fit: BoxFit.fill,
                ),
              ),
              Column(children: [
                ///appbar
                ProfileAppbar(
                  title: AppLocalizations.of(context)?.kEmergencyContactLabel,
                ),
                Expanded(
                  child: RefreshIndicator(
                    backgroundColor: kBackgroundColor,
                    elevation: 0.0,
                    onRefresh: () async {
                      HapticFeedback.mediumImpact();
                      bloc.getEmergency();
                    },
                    child: bloc.isLoading == true
                        ? LoadingView()
                        : bloc.emergencyLists.isEmpty
                            ? EmptyView(
                                imagePath: kNoAnnouncementImage,
                                title: AppLocalizations.of(context)
                                        ?.kNoEmergencyLabel ??
                                    '',
                                subTitle: AppLocalizations.of(context)
                                        ?.kThereIsNoEmergencyLabel ??
                                    '')
                            : ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kMarginMedium2, vertical: 15),
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: bloc.isLoadMore == true
                                    ? bloc.emergencyLists.length + 1
                                    : bloc.emergencyLists.length,
                                itemBuilder: (context, index) {
                                  if (index == bloc.emergencyLists.length) {
                                    return LoadingView(
                                      bgColor: Colors.transparent,
                                    );
                                  }
                                  return _buildListItem(
                                      data: bloc.emergencyLists[index],
                                      index: index,
                                      title: bloc
                                          .emergencyLists[index].emergencyCategory?.name);
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
              ]),
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
          style: TextStyle(fontSize: kTextRegular),
        ),
        Text(
          value,
          style: TextStyle(
              color: isNumber == true ? kBlueColor : kBlackColor,
              fontSize: kTextRegular2x + 1,
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
                blurRadius: 5,
                color: kGreyColor)
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
                  fontSize: kTextRegular,
                  fontWeight: FontWeight.w700),
            ),
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: kMargin10, horizontal: kMargin10 + 5),
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
                        title:
                            AppLocalizations.of(context)?.kContactNameLabel ??
                                '',
                        value: data?.contractName ?? ''),
                    _listItem(
                        title:
                            AppLocalizations.of(context)?.kAddressLabel ?? '',
                        value: data?.address ?? ''),
                    GestureDetector(
                      onTap: () => makePhoneCall(data?.phone1 ?? ''),
                      child: _listItem(
                          title:
                              '${AppLocalizations.of(context)?.kTelephoneNormalLabel} (Office Hours)',
                          value: data?.phone1 ?? '',
                          isNumber: true),
                    ),
                    GestureDetector(
                      onTap: () => makePhoneCall(data?.phone2 ?? ''),
                      child: _listItem(
                          title: AppLocalizations.of(context)
                                  ?.kTelephoneNormal24Label ??
                              '',
                          value: data?.phone2 ?? '',
                          isNumber: true),
                    ),
                    _listItem(
                        title:
                            AppLocalizations.of(context)?.kContractRefLabel ??
                                '',
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
