import 'package:flutter/material.dart';
import 'package:tmsmobile/data/vos/service_request_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/number_extension.dart';
import 'package:tmsmobile/network/responses/fillout_process_response.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/strings.dart';

import '../../data/app_data/app_data.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import '../../widgets/cache_image.dart';
import '../../widgets/image_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FillOutProcessDetailPage extends StatelessWidget {
  const FillOutProcessDetailPage(
      {super.key, this.isApproved, this.data, required this.fillOutData});
  final bool? isApproved;
  final FilloutProcessData? data;
  final ServiceRequestVo fillOutData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kMargin60),
          child: GradientAppBar(
            AppLocalizations.of(context)?.kDetailLabel ?? '',
          )),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kMarginMedium2, vertical: kMarginMedium2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListDetail(
                title: AppLocalizations.of(context)?.kIDLabel ?? '',
                value: '#${fillOutData.id}'),
            isApproved == false ? 10.vGap : 0.vGap,
            Visibility(
              visible: isApproved == false,
              child: _buildListDetail(
                  title: AppLocalizations.of(context)?.kDateLabel ?? '',
                  value: isApproved == true
                      ? DateFormatter.formatDate2(
                          data?.approveDate ?? DateTime.now())
                      : DateFormatter.formatDate2(
                          data?.pendingDate ?? DateTime.now())),
            ),
            Visibility(
              visible: isApproved ?? false,
              child: Padding(
                padding: const EdgeInsets.only(top: kMargin12),
                child: _buildListDetail(
                    title:
                        AppLocalizations.of(context)?.kServicingDateLabel ?? '',
                    value: data?.serviceDate?.replaceAll(' ', ', ') ?? '',
                    isServicingDate: true),
              ),
            ),
            kMargin12.vGap,
            _buildListDetail(
                title: AppLocalizations.of(context)?.kTenantNameLabel ?? '',
                value: fillOutData.tenant?.tenantName ?? ''),
            kMargin12.vGap,
            _buildListDetail(
                title: AppLocalizations.of(context)?.kRoomShopNameLabel ?? '',
                value: '#${fillOutData.shop?.name}'),
            isApproved == true ? 10.vGap : 10.vGap,
            Visibility(
                visible: isApproved ?? true,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: kMargin10),
                  child: _buildListDetail(
                      title: AppLocalizations.of(context)?.kDepositLabel ?? '',
                      value: fillOutData.depositAmount == null
                          ? '0 MMk'
                          : '${fillOutData.depositAmount.toString().format} MMK',
                      isDeposit: true),
                )),
            _buildStatusListItem(
                status: data?.statusName ?? '', context: context),
            isApproved == true ? 10.vGap : 0.vGap,
            Visibility(
                visible: isApproved == false,
                child: _buildDescription(context)),
            Visibility(
                visible: isApproved == true && data?.amount != null,
                child: _buildDayExtension()),
            _buildImageView(data?.photos ?? []),
          ],
        ),
      ),
    );
  }

  Widget _buildDayExtension() {
    return Container(
      margin: EdgeInsets.only(top: kMarginMedium, bottom: 10),
      padding: EdgeInsets.all(kMargin12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            kMargin10,
          ),
          color: kBlueColor.withValues(alpha: 0.08)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: kMargin12,
        children: [
          Text(
            kDayExtensionDayLabel,
            style: TextStyle(
                fontSize: AppData.shared.getRegularFontSize(),
                fontWeight: FontWeight.w700),
          ),
          _buildListDetail(
              title: kServicingDateLabel,
              value: data?.serviceDate?.replaceAll(' ', ', ') ?? '',
              isServicingDate: true),
          _buildListDetail(title: kExtensionDayLabel, value: '-'),
          _buildListDetail(
              title: kAmountLabel,
              value: '${data?.amount.toString().format} MMK',
              isDeposit: true),
        ],
      ),
    );
  }

  Widget _buildStatusListItem({required String status, BuildContext? context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context!)?.kStatusLabel ?? '',
          style: TextStyle(fontSize: kTextRegular),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: kMarginMedium + 5, vertical: kMargin5 - 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kMarginMedium2),
              color: status == 'approve'
                  ? kBlueColor.withValues(alpha: 0.12)
                  : kBlackColor.withValues(alpha: 0.12)),
          child: FittedBox(
            child: Text(
              status,
              style: TextStyle(
                  fontSize: kTextRegular,
                  fontWeight: FontWeight.w700,
                  color: status == 'approve' ? kBlueColor : kBlackColor),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildListDetail(
      {required String title,
      required String value,
      bool? isServicingDate,
      bool? isDeposit}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: kTextRegular),
        ),
        kSize40.hGap,
        Expanded(
          child: Text(
            value,
            softWrap: true,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: kTextRegular,
                fontWeight: FontWeight.w700,
                color: isServicingDate == true
                    ? kRedColor
                    : isDeposit == true
                        ? kPrimaryColor
                        : kBlackColor),
          ),
        )
      ],
    );
  }

  Widget _buildImageView(List<String> photos) {
    return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: kMargin10),
        physics: NeverScrollableScrollPhysics(),
        itemCount: photos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: kMarginMedium2,
            crossAxisSpacing: kMarginMedium2,
            mainAxisExtent: 216),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => showDialogImage(context, photos[index]),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: cacheImage(photos[index]),
            ),
          );
        });
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.vGap,
        Text(
          kDescriptionLabel,
          style: TextStyle(
              fontFamily: AppData.shared.fontFamily2,
              fontSize: kTextRegular3x,
              fontWeight: FontWeight.w700),
        ),
        10.vGap,
        Text(
          fillOutData.description ?? '',
          style: TextStyle(fontSize: kTextRegular),
        ),
        10.vGap,
      ],
    );
  }
}
