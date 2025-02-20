import 'package:flutter/material.dart';
import 'package:tmsmobile/data/vos/service_request_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/network/responses/fillout_process_response.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/strings.dart';

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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: kMargin12,
        children: [
          10.vGap,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
            child: Column(
              children: [
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kIDLabel ?? '',
                    value: '#${fillOutData.id}'),
                kMargin12.vGap,
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kDateLabel ?? '',
                    value: isApproved == true
                        ? DateFormatter.formatDate(
                            data?.approveDate ?? DateTime.now())
                        : DateFormatter.formatDate(
                            data?.pendingDate ?? DateTime.now())),
                Visibility(
                  visible: isApproved ?? false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: kMargin12),
                    child: _buildListDetail(
                        title: kServicingDateLabel,
                        value: data?.serviceDate?.split(' ')[0] ?? '',
                        isServicingDate: true),
                  ),
                ),
                kMargin12.vGap,
                _buildListDetail(
                    title: AppLocalizations.of(context)?.kTenantNameLabel ?? '',
                    value: fillOutData.tenant?.tenantName ?? ''),
                kMargin12.vGap,
                _buildListDetail(
                    title:
                        AppLocalizations.of(context)?.kRoomShopNameLabel ?? '',
                    value: fillOutData.shop?.name ?? ''),
                10.vGap,
                Visibility(
                    visible: isApproved ?? true,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: kMargin10),
                      child: _buildListDetail(
                          title:
                              AppLocalizations.of(context)?.kDepositLabel ?? '',
                          value: '${data?.depositAmount ?? 0} ks',
                          isDeposit: true),
                    )),
                _buildStatusListItem(
                    status: data?.statusName ?? '', context: context),
                20.vGap,
                _buildImageView(data?.photos ?? [])
                // 10.vGap,
                // Visibility(
                //     visible: isApproved == false,
                //     child: _buildDescription(context)),
                // Visibility(
                //   visible: isApproved == true,
                //   child: _buildDayExtension()),
              ],
            ),
          ),
          10.vGap
        ],
      ),
    );
  }

  // Widget _buildDayExtension() {
  //   return Container(
  //     margin: EdgeInsets.only(top: kMarginMedium2),
  //     padding: EdgeInsets.all(kMargin12),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(
  //           kMargin10,
  //         ),
  //         color: kNewBlueColor.withValues(alpha: 0.08)),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       spacing: kMargin12,
  //       children: [
  //         Text(
  //           kDayExtensionDayLabel,
  //           style: TextStyle(
  //               fontSize: AppData.shared.getRegularFontSize(), fontWeight: FontWeight.w700),
  //         ),
  //         _buildListDetail(
  //             title: kServicingDateLabel,
  //             value: '12 Dec, 2024',
  //             isServicingDate: true),
  //         _buildListDetail(title: kExtensionDayLabel, value: 'value'),
  //         _buildListDetail(
  //             title: kAmountLabel, value: '50000 ks', isDeposit: true),
  //       ],
  //     ),
  //   );
  // }

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
              horizontal: kMarginMedium, vertical: kMargin5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kMarginMedium2),
              color: status == 'approve'
                  ? kPrimaryColor.withValues(alpha: 0.12)
                  : kBlackColor.withValues(alpha: 0.12)),
          child: FittedBox(
            child: Text(
              status,
              style: TextStyle(
                  fontSize: kTextRegular,
                  fontWeight: FontWeight.w700,
                  color: kBlackColor),
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
  // Widget _buildDescription(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         kDescriptionLabel,
  //         style: TextStyle(
  //                         fontFamily: AppData.shared.fontFamily2,
  //             fontSize: kTextRegular3x, fontWeight: FontWeight.w700),
  //       ),
  //       10.vGap,
  //       Text(
  //         'Lorem ipsum dolor sit amet consectetur. Eget neque gravida tellus vitae quis a. Aliquam a sagittis nibh ipsum. Tincidunt tristique bibendum adipiscing id volutpat lectus. Ullamcorper magna amet nibh venenatis risus. ',
  //         style: TextStyle(fontSize: kTextRegular),
  //       ),
  //       kMarginMedium2.vGap,
  //     ],
  //   );
  // }
}
