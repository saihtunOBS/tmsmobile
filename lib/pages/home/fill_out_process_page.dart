import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/fillout_process_bloc.dart';
import 'package:tmsmobile/data/vos/service_request_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/home/fill_out_process_detail_page.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/loading_view.dart';

import '../../utils/colors.dart';
import '../../utils/date_formatter.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import 'package:tmsmobile/l10n/app_localizations.dart';

class FillOutProcessPage extends StatefulWidget {
  const FillOutProcessPage(
      {super.key, this.status, required this.id, required this.fillOutData});
  final int? status;
  final String id;
  final ServiceRequestVo fillOutData;

  @override
  State<FillOutProcessPage> createState() => _FillOutProcessPageState();
}

class _FillOutProcessPageState extends State<FillOutProcessPage> {
  bool isSelectedPending = true;
  bool isSelectedApprove = false;
  bool isSelectedClose = false;

  @override
  void initState() {
    implementStatus(widget.status ?? 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FilloutProcessBloc(widget.id),
      child: Consumer<FilloutProcessBloc>(
        builder: (context, bloc, child) => Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: PreferredSize(
              preferredSize: Size(double.infinity, kMargin60),
              child: GradientAppBar(
                AppLocalizations.of(context)?.kFillOutProcessLabel ?? '',
              )),
          body: bloc.isLoading == true ? LoadingView() : _buildSetpper(bloc),
        ),
      ),
    );
  }

  void implementStatus(int status) {
    switch (status) {
      case 1:
        isSelectedPending = true;
      case 2:
        isSelectedPending = true;
        isSelectedApprove = true;
      case 3 || 4:
        isSelectedPending = true;
        isSelectedApprove = true;
        isSelectedClose = true;
        break;
      default:
        isSelectedPending = false;
        setState(() {});
    }
  }

  Widget _buildSetpper(FilloutProcessBloc bloc) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
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
                      _buildProcessView(
                          date: bloc.pendingDate != null
                              ? DateFormatter.formatDate2(
                                  bloc.pendingDate ?? DateTime.now())
                              : '',
                          title: kPendingLabel,
                          onPressDetail: () => PageNavigator(ctx: context)
                                  .nextPage(
                                      page: FillOutProcessDetailPage(
                                isApproved: false,
                                data: bloc.pendingVO,
                                fillOutData: widget.fillOutData,
                              ))
                                  .whenComplete(() {
                                bloc.getFilloutProcess();
                              }),
                          onPressed: () {
                            // setState(() {
                            //   isSelectedPending = true;
                            // });
                          },
                          label: 'Fill Out Request',
                          isSelected: isSelectedPending,
                          color: kBlackColor),
                      _buildProcessView(
                          date: DateFormatter.formatDate2(
                              widget.fillOutData.approveDate ?? DateTime.now()),
                          title: kApprovedLabel,
                          onPressDetail: () => PageNavigator(ctx: context)
                                  .nextPage(
                                      page: FillOutProcessDetailPage(
                                isApproved: true,
                                data: bloc.approveVO,
                                fillOutData: widget.fillOutData,
                              ))
                                  .whenComplete(() {
                                bloc.getFilloutProcess();
                              }),
                          onPressed: () {
                            // setState(() {
                            //   if (isSelectedPending == false) return;
                            //   isSelectedApprove = true;
                            // });
                          },
                          label: 'Fill Out Request Approve',
                          isSelected: isSelectedApprove,
                          color: kPrimaryColor),
                      _buildProcessView(
                          title: kCloseLabel,
                          onPressed: () {
                            // setState(() {
                            //   if (isSelectedApprove == false) return;
                            //   isSelectedClose = true;
                            // });
                          },
                          label: 'Closed',
                          isSelected: false,
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
      String? date,
      Key? key,
      String? label,
      VoidCallback? onPressDetail,
      bool? isSelected,
      required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMargin10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //body
          GestureDetector(
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
          GestureDetector(
            onTap: onPressDetail,
            child: AnimatedSize(
              duration: Duration(milliseconds: 100),
              child: Container(
                height: isSelected == true ? null : 0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(kMargin6),
                    boxShadow: [
                      isSelected == false
                          ? BoxShadow()
                          : BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 5,
                              color: kGreyColor)
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
                            date ?? '',
                            style: TextStyle(fontSize: kTextRegular - 2),
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
                                  AppLocalizations.of(context)?.kDetailLabel ??
                                      '',
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

  Widget _buildDotView({bool? isLast, bool? isSelectedIndex}) {
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
                  height: isSelectedIndex == true ? kSize110 : kSize43,
                ),
              ),
      ],
    );
  }
}
