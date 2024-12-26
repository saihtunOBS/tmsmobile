import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/strings.dart';

import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';

class MaintenanceProcessPage extends StatefulWidget {
  const MaintenanceProcessPage({super.key});

  @override
  State<MaintenanceProcessPage> createState() => _MaintenanceProcessPageState();
}

final _surveyKey = GlobalKey();
class _MaintenanceProcessPageState extends State<MaintenanceProcessPage> {
  bool isSelectedPending = false;
  bool isSelectedSurvey = false;
  bool isSelectedQuotation = false;
  bool isSelectedAcceptReject = false;
  bool isSelectedProcessing = false;
  bool isSelectedFinish = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: GradientAppBar(
            kMaintenanceProcessLabel,
          )),
      body: _buildSetpper(),
    );
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
                          isSelectedIndex: isSelectedSurvey, isSurvey: true),
                      _buildDotView(isSelectedIndex: isSelectedQuotation),
                      _buildDotView(isSelectedIndex: isSelectedAcceptReject),
                      _buildDotView(isSelectedIndex: isSelectedProcessing),
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
                          onPressed: () {
                            setState(() {
                              isSelectedPending = !isSelectedPending;
                            });
                          },
                          isSelected: isSelectedPending,
                          color: kBlackColor),
                      _buildProcessView(
                          title: kSurveyLabel,
                          key: _surveyKey,
                          onPressed: () {
                            setState(() {
                              isSelectedSurvey = !isSelectedSurvey;
                            });
                          },
                          isSelected: isSelectedSurvey,
                          color: kOrangeColor),
                      _buildProcessView(
                          title: kQuotationLabel,
                          onPressed: () {
                            setState(() {
                              isSelectedQuotation = !isSelectedQuotation;
                            });
                          },
                          isSelected: isSelectedQuotation,
                          color: kGreenColor),
                      _buildProcessView(
                          title: kAcceptRejectLabel,
                          onPressed: () {
                            setState(() {
                              isSelectedAcceptReject = !isSelectedAcceptReject;
                            });
                          },
                          isSelected: isSelectedAcceptReject,
                          color: kBlueColor),
                      _buildProcessView(
                          title: kProcessingLabel,
                          onPressed: () {
                            setState(() {
                              isSelectedProcessing = !isSelectedProcessing;
                            });
                          },
                          isSelected: isSelectedProcessing,
                          color: kYellowColor),
                      _buildProcessView(
                          title: kFinishLabel,
                          onPressed: () {
                            setState(() {
                              isSelectedFinish = !isSelectedFinish;
                            });
                          },
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
      bool? isSelected,
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
              print(_surveyKey.currentContext?.size?.height);
            } ,
            child: Container(
              key: key,
                height: 26,
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
          AnimatedSize(
            duration: Duration(milliseconds: 100),
            child: Container(
              height: isSelected == true ? null : 0,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(kMargin6),
                  boxShadow: [
                    BoxShadow(
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
                          'Maintenance Request',
                          style: TextStyle(
                              fontSize: kTextRegular2x,
                              fontWeight: FontWeight.w700),
                        ),
                        title == kSurveyLabel
                            ? Text(
                                'We will arrive to survey within two days..',
                                style: TextStyle(fontSize: kTextRegular13),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  title == kSurveyLabel
                      ? SizedBox()
                      : Positioned(
                          bottom: - kMarginMedium3,
                          right: 0,
                          child: Container(
                            height: 26,
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
          )
        ],
      ),
    );
  }

  Widget _buildDotView({bool? isLast, bool? isSelectedIndex, bool? isSurvey}) {
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
                  height: isSelectedIndex == true && isSurvey == true
                      ? 130
                      : isSelectedIndex == true
                          ? 110
                          : 43,
                ),
              ),
      ],
    );
  }
}
