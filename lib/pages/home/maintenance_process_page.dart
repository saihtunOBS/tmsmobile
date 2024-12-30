import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/home/maintenance_pending_page.dart';
import 'package:tmsmobile/pages/home/maintenance_processing_page.dart';
import 'package:tmsmobile/pages/home/maintenance_quotation_page.dart';
import 'package:tmsmobile/utils/strings.dart';

import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';

class MaintenanceProcessPage extends StatefulWidget {
  const MaintenanceProcessPage({super.key, this.status});
  final String? status;
  @override
  State<MaintenanceProcessPage> createState() => _MaintenanceProcessPageState();
}

final _surveyKey = GlobalKey();

class _MaintenanceProcessPageState extends State<MaintenanceProcessPage> {
  bool isSelectedPending = true;
  bool isSelectedSurvey = false;
  bool isSelectedQuotation = false;
  bool isSelectedAcceptReject = false;
  bool isSelectedProcessing = false;
  bool isSelectedFinish = false;

  @override
  void initState() {
    implementStatus(widget.status ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kMargin60),
          child: GradientAppBar(
            kMaintenanceProcessLabel,
          )),
      body: _buildSetpper(),
    );
  }

  void implementStatus(String status) {
    switch (status) {
      case kPendingLabel:
        isSelectedPending = true;
      case kSurveyLabel:
        isSelectedPending = true;
        isSelectedSurvey = true;
      case kQuotationLabel:
        isSelectedPending = true;
        isSelectedSurvey = true;
        isSelectedQuotation = true;
      case kAcceptRejectLabel:
        isSelectedPending = true;
        isSelectedSurvey = true;
        isSelectedQuotation = true;
        isSelectedAcceptReject = true;
      case kProcessingLabel:
        isSelectedPending = true;
        isSelectedSurvey = true;
        isSelectedQuotation = true;
        isSelectedAcceptReject = true;
        isSelectedProcessing = true;
      case kFinishLabel:
        isSelectedPending = true;
        isSelectedSurvey = true;
        isSelectedQuotation = true;
        isSelectedAcceptReject = true;
        isSelectedProcessing = true;
        isSelectedFinish = true;
        break;
      default: isSelectedPending = false;
        setState(() {});
    }
  }

  Widget _buildSetpper() {
    return SingleChildScrollView(
      child: Column(
          spacing: kMargin30,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            1.vGap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: kMarginMedium2 + kMargin5, top: kMargin5),
                  child: Column(
                    children: [
                      _buildDotView(isSelectedIndex: isSelectedPending),
                      _buildDotView(
                          isSelectedIndex: isSelectedSurvey,
                          isSurveyAndProcessing: true),
                      _buildDotView(isSelectedIndex: isSelectedQuotation),
                      _buildDotView(isSelectedIndex: isSelectedAcceptReject),
                      _buildDotView(
                          isSelectedIndex: isSelectedProcessing,
                          isSurveyAndProcessing: true),
                      _buildDotView(
                          isLast: true, isSelectedIndex: isSelectedFinish),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: kMarginMedium2,
                    children: [
                      _buildProcessView(
                          title: kPendingLabel,
                          onPressedDetail: () => PageNavigator(ctx: context)
                            .nextPage(page: MaintenancePendingPage()),
                          onPressed: () {
                            setState(() {
                              isSelectedPending = true;
                            });
                          },
                          label: 'Maintenance Request',
                          isSelected: isSelectedPending,
                          color: kBlackColor),
                      _buildProcessView(
                          title: kSurveyLabel,
                          key: _surveyKey,
                          onPressed: () {
                            setState(() {
                              if (isSelectedPending == false) return;
                              isSelectedSurvey = true;
                            });
                          },
                          label: kSurveyStateLabel,
                          isSelected: isSelectedSurvey,
                          color: kOrangeColor),
                      _buildProcessView(
                          title: kQuotationLabel,
                          onPressedDetail: () => PageNavigator(ctx: context)
                          .nextPage(page: MaintenanceQuotationPage()),
                          onPressed: () {
                            setState(() {
                               if (isSelectedSurvey == false) return;
                              isSelectedQuotation = true;
                            });
                          },
                          label: kQuotationStateLabel,
                          isSelected: isSelectedQuotation,
                          color: kGreenColor),
                      _buildProcessView(
                          title: kAcceptRejectLabel,
                          onPressed: () {
                            setState(() {
                              if (isSelectedQuotation == false) return;
                              isSelectedAcceptReject = true;
                            });
                          },
                          label: kDecisionStateLabel,
                          isSelected: isSelectedAcceptReject,
                          color: kBlueColor),
                      _buildProcessView(
                          title: kProcessingLabel,
                          onPressedDetail: () => MaintenanceProcessingPage,
                          onPressed: () {
                            setState(() {
                              if (isSelectedAcceptReject == false) return;
                              isSelectedProcessing = true;
                            });
                          },
                          label: kProcessingStateLabel,
                          isSelected: isSelectedProcessing,
                          color: kYellowColor),
                      _buildProcessView(
                          title: kFinishLabel,
                          onPressed: () {
                            setState(() {
                              if (isSelectedProcessing == false) return;
                              isSelectedFinish = true;
                            });
                          },
                          label: kSuccessFinishLabel,
                          isSelected: isSelectedFinish,
                          color: kPurpleColor),
                    ],
                  ),
                ),
              ],
            ),
            24.vGap
          ]),
    );
  }

  Widget _buildProcessView(
      {required String title,
      required VoidCallback onPressed,
      Key? key,
      String? label,
      bool? isSelected,
      VoidCallback? onPressedDetail,
      required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMargin10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //body
          InkWell(
            onTap: () {
              onPressed();
            },
            child: Container(
                key: key,
                height: kSize26,
                padding: EdgeInsets.symmetric(
                    horizontal: kMargin12, vertical: kMargin5 - 2),
                decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(kMarginMedium14)),
                child: FittedBox(
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: kTextRegular, color: color),
                    ),
                  ),
                )),
          ),
          10.vGap,
          InkWell(
            onTap: onPressedDetail,
            child: AnimatedSize(
              duration: Duration(milliseconds: 100),
              child: Container(
                height: isSelected == true ? null : 0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(kMargin6),
                    boxShadow: [
                     isSelected == false ? BoxShadow() : BoxShadow(
                          offset: Offset(0, 4), blurRadius: 5, color: kGreyColor)
                    ]),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMargin10, vertical: kMargin10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dec 12, 2024',
                            style: TextStyle(fontSize: kTextRegular13),
                          ),
                          6.vGap,
                          Text(
                            label ?? '',
                            style: TextStyle(
                                fontSize: kTextRegular2x,
                                fontWeight: FontWeight.w700),
                          ),
                          title == kSurveyLabel || title == kProcessingLabel
                              ? Text(
                                  'We will arrive to survey within two days..',
                                  style: TextStyle(fontSize: kTextRegular13),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    title == kSurveyLabel || title == kAcceptRejectLabel
                        ? SizedBox()
                        : Positioned(
                            bottom: -kMarginMedium3,
                            right: 0,
                            child: Container(
                              height: kSize26,
                              margin: EdgeInsets.only(bottom: kMarginMedium3),
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(kMargin12),
                                      bottomRight: Radius.circular(kMargin6))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: kMarginMedium + 5),
                              child: Center(
                                child: Text(
                                  kDetailLabel,
                                  style: TextStyle(
                                      fontSize: kTextSmall,
                                      color: kWhiteColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDotView(
      {bool? isLast, bool? isSelectedIndex, bool? isSurveyAndProcessing}) {
    return Column(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelectedIndex == true ? kPrimaryColor : kGreyColor),
        ),
        isLast == true
            ? SizedBox()
            : AnimatedSize(
                duration: Duration(milliseconds: 100),
                child: Container(
                  width: 2,
                  color: isSelectedIndex == true ? kPrimaryColor : kGreyColor,
                  height:
                      isSelectedIndex == true && isSurveyAndProcessing == true
                          ? kSize130
                          : isSelectedIndex == true
                              ? kSize110
                              : kSize43,
                ),
              ),
      ],
    );
  }
}
