import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/home/fill_out_process_detail_page.dart';
import 'package:tmsmobile/utils/strings.dart';

import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';

class FillOutProcessPage extends StatefulWidget {
  const FillOutProcessPage({super.key, this.status});
  final String? status;
  @override
  State<FillOutProcessPage> createState() => _FillOutProcessPageState();
}

class _FillOutProcessPageState extends State<FillOutProcessPage> {
  bool isSelectedPending = true;
  bool isSelectedApprove = false;
  bool isSelectedClose = false;

  @override
  void initState() {
    implementStatus(widget.status ?? '');
    super.initState();
  }

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

  void implementStatus(String status) {
    switch (status) {
      case kPendingLabel:
        isSelectedPending = true;
      case kApprovedLabel:
        isSelectedPending = true;
        isSelectedApprove = true;
      case kCloseLabel:
        isSelectedPending = true;
        isSelectedApprove = true;
        isSelectedClose = true;
        break;
      default:
        isSelectedPending = false;
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
                      _buildDotView(isSelectedIndex: isSelectedApprove),
                      _buildDotView(
                          isSelectedIndex: isSelectedClose, isLast: true),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: kMarginMedium2,
                    children: [
                      InkWell(
                        onTap: () => PageNavigator(ctx: context)
                            .nextPage(page: FillOutProcessDetailPage(isApproved: false,)),
                        child: _buildProcessView(
                            title: kPendingLabel,
                            onPressed: () {
                              setState(() {
                                isSelectedPending = true;
                              });
                            },
                            label: 'Fill Out Request',
                            isSelected: isSelectedPending,
                            color: kBlackColor),
                      ),
                      InkWell(
                        onTap: () => PageNavigator(ctx: context)
                            .nextPage(page: FillOutProcessDetailPage(isApproved: true,)),
                        child: _buildProcessView(
                            title: kApprovedLabel,
                            onPressed: () {
                              setState(() {
                                if (isSelectedPending == false) return;
                                isSelectedApprove = true;
                              });
                            },
                            label: 'Fill Out Request Approve',
                            isSelected: isSelectedApprove,
                            color: kPrimaryColor),
                      ),
                      _buildProcessView(
                          title: kCloseLabel,
                          onPressed: () {
                            setState(() {
                              if (isSelectedApprove == false) return;
                              isSelectedClose = true;
                            });
                          },
                          label: 'Closed',
                          isSelected: isSelectedClose,
                          color: kRedColor),
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
                          label ?? '',
                          style: TextStyle(
                              fontSize: kTextRegular2x,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  title == kSurveyLabel || title == kAcceptRejectLabel
                      ? SizedBox()
                      : Positioned(
                          bottom: -kMarginMedium3,
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
