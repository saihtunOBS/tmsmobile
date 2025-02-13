import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/maintenance_process_bloc.dart';
import 'package:tmsmobile/data/vos/quotation_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/home/invoice_detail_page.dart';
import 'package:tmsmobile/pages/home/maintenance_pending_page.dart';
import 'package:tmsmobile/pages/home/maintenance_processing_page.dart';
import 'package:tmsmobile/pages/home/maintenance_quotation_page.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/vos/pending_vo.dart';
import '../../extension/text_ext.dart';
import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';

class MaintenanceProcessPage extends StatefulWidget {
  const MaintenanceProcessPage({super.key, this.status, this.id});
  final int? status;
  final String? id;
  @override
  State<MaintenanceProcessPage> createState() => _MaintenanceProcessPageState();
}

class _MaintenanceProcessPageState extends State<MaintenanceProcessPage> {
  bool isSelectedPending = true;
  bool isSelectedSurvey = false;
  bool isSelectedQuotation = false;
  bool isSelectedAcceptReject = false;
  bool isSelectedProcessing = false;
  bool isSelectedFinish = false;

  bool isWrapSurveyText = false;
  bool isWrapProcessingText = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isWrapSurveyText = isTextWrapped(
          text: 'We will arrive to survey within two days.',
          maxWidth: MediaQuery.of(context).size.width);
      isWrapProcessingText = isTextWrapped(
          text: 'We will arrive to fix within two days.',
          maxWidth: MediaQuery.of(context).size.width);
      implementStatus(widget.status ?? 1);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MaintenanceProcessBloc(widget.id),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kMargin60),
            child: GradientAppBar(
              AppLocalizations.of(context)?.kMaintenanceProcessLabel ?? '',
            )),
        body: Consumer<MaintenanceProcessBloc>(
            builder: (context, bloc, child) =>
                bloc.isLoading ? LoadingView() : _buildSetpper()),
      ),
    );
  }

  void implementStatus(int status) {
    switch (status) {
      case 1:
        isSelectedPending = true;
      case 2:
        isSelectedPending = true;
        isSelectedSurvey = true;
      case 3:
        isSelectedPending = true;
        isSelectedSurvey = true;
        isSelectedQuotation = true;
      case 4:
        isSelectedPending = true;
        isSelectedSurvey = true;
        isSelectedQuotation = true;
        isSelectedAcceptReject = true;
      case 5:
        isSelectedPending = true;
        isSelectedSurvey = true;
        isSelectedQuotation = true;
        isSelectedAcceptReject = true;
      case 6:
        isSelectedPending = true;
        isSelectedSurvey = true;
        isSelectedQuotation = true;
        isSelectedAcceptReject = true;
        isSelectedProcessing = true;
      case 7:
        isSelectedPending = true;
        isSelectedSurvey = true;
        isSelectedQuotation = true;
        isSelectedAcceptReject = true;
        isSelectedProcessing = true;
        isSelectedFinish = true;
      default:
        isSelectedPending = false;
        setState(() {});
    }
  }

  Widget _buildSetpper() {
    return Consumer<MaintenanceProcessBloc>(
      builder: (context, bloc, child) => SingleChildScrollView(
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
                        _buildDotView(
                            isSelectedIndex: isSelectedProcessing,
                            isProcessing: true),
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
                            date: DateFormatter.formatStringDate(
                                bloc.pendingDate ?? ''),
                            title: kPendingLabel,
                            onPressedDetail: () =>
                                PageNavigator(ctx: context).nextPage(
                                    page: MaintenancePendingPage(
                                  pendingData: bloc.pendingVO ?? PendingVO(),
                                )),
                            onPressed: () {
                              // setState(() {
                              //   isSelectedPending = true;
                              // });
                            },
                            label: 'Maintenance Request',
                            isSelected: isSelectedPending,
                            color: kBlackColor),
                        _buildProcessView(
                            date: bloc.surveyDate != null
                                ? DateFormatter.formatStringDate(
                                    bloc.surveyDate ?? '')
                                : '',
                            title: kSurveyLabel,
                            surveyProcessingText:
                                'We will arrive to survey within two days.',
                            onPressed: () {
                              // setState(() {
                              //   if (isSelectedPending == false) return;
                              //   isSelectedSurvey = true;
                              // });
                            },
                            label: kSurveyStateLabel,
                            isSelected: isSelectedSurvey,
                            color: kOrangeColor),
                        _buildProcessView(
                            date: bloc.quotationDate != null
                                ? DateFormatter.formatStringDate(
                                    bloc.quotationDate ?? '')
                                : '',
                            title: kQuotationLabel,
                            onPressedDetail: () => PageNavigator(ctx: context)
                                    .nextPage(
                                        page: MaintenanceQuotationPage(
                                  quotation: bloc.quotationVO ?? QuotationVO(),id: widget.id ?? '',
                                ))
                                    .whenComplete(() {
                                  bloc.getMaintenanceProcess();
                                  implementStatus(bloc.pendingVO?.status ?? 0);
                                }),
                            onPressed: () {
                              // setState(() {
                              //   if (isSelectedSurvey == false) return;
                              //   isSelectedQuotation = true;
                              // });
                            },
                            label: kQuotationStateLabel,
                            isSelected: isSelectedQuotation,
                            color: kGreenColor),
                        _buildProcessView(
                            date: bloc.acceptRejectDate != null
                                ? DateFormatter.formatStringDate(
                                    bloc.acceptRejectDate ?? '')
                                : '',
                            title: kAcceptRejectLabel,
                            onPressed: () {
                              // setState(() {
                              //   if (isSelectedQuotation == false) return;
                              //   isSelectedAcceptReject = true;
                              // });
                            },
                            label: kDecisionStateLabel,
                            isSelected: isSelectedAcceptReject,
                            color: kBlueColor),
                        _buildProcessView(
                            date: bloc.processingDate != null
                                ? DateFormatter.formatStringDate(
                                    bloc.processingDate ?? '')
                                : '',
                            title: kProcessingLabel,
                            surveyProcessingText:
                                'We will arrive to fix within two days.',
                            onPressedDetail: () => PageNavigator(ctx: context)
                                .nextPage(page: MaintenanceProcessingPage()),
                            onPressed: () {
                              // setState(() {
                              //   if (isSelectedAcceptReject == false) return;
                              //   isSelectedProcessing = true;
                              // });
                            },
                            label: kProcessingStateLabel,
                            isSelected: isSelectedProcessing,
                            color: kYellowColor),
                        _buildProcessView(
                            date: bloc.finishedDate != null
                                ? DateFormatter.formatStringDate(
                                    bloc.finishedDate ?? '')
                                : '',
                            title: kFinishLabel,
                            onPressedDetail: () => PageNavigator(ctx: context)
                                .nextPage(page: InvoiceDetailPage()),
                            onPressed: () {
                              // setState(() {
                              //   if (isSelectedProcessing == false) return;
                              //   isSelectedFinish = true;
                              // });
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
      ),
    );
  }

  Widget _buildProcessView(
      {required String title,
      required VoidCallback onPressed,
      String? label,
      bool? isSelected,
      String? surveyProcessingText,
      String? date,
      VoidCallback? onPressedDetail,
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
                            style: TextStyle(fontSize: kTextRegular),
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
                                  surveyProcessingText ?? '',
                                  style: TextStyle(fontSize: kTextRegular),
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
      {bool? isLast,
      bool? isSelectedIndex,
      bool? isSurvey,
      bool? isProcessing}) {
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
                  height: isSelectedIndex == true
                      ? isSurvey == true
                          ? isWrapSurveyText == true
                              ? kSize130 + 9
                              : kSize130 + 1
                          : isProcessing == true
                              ? isWrapProcessingText == true
                                  ? kSize130 + 9
                                  : kSize130 + 1
                              : kSize110 + 1 
                      : kSize43,
                ),
              ),
      ],
    );
  }
}
