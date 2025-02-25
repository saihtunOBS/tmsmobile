import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/widgets/cache_image.dart';
import 'package:tmsmobile/widgets/image_view.dart';

import '../../data/app_data/app_data.dart';
import '../../data/vos/pending_vo.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaintenancePendingPage extends StatelessWidget {
  const MaintenancePendingPage({super.key, required this.pendingData});
  final PendingVO pendingData;

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
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kMarginMedium2, vertical: kMarginMedium2),
        child: Column(
          spacing: kMargin12,
          children: [
            // _buildListDetail(title: kIDLabel, value: 'value'),
            _buildListDetail(
                title: AppLocalizations.of(context)?.kDateLabel ?? '',
                value: DateFormatter.formatStringDate(
                    pendingData.pendingDate ?? '')),
            _buildListDetail(
                title: AppLocalizations.of(context)?.kTenantNameLabel ?? '',
                value: pendingData.tenant ?? ''),
            _buildListDetail(
                title: AppLocalizations.of(context)?.kRoomShopNameLabel ?? '',
                value: pendingData.shop ?? ''),
            _buildListDetail(
                title: AppLocalizations.of(context)?.kTypeOfIssueLabel ?? '',
                value: pendingData.issue ?? ''),
            _buildStatusListItem(status: 'Pending', context: context),
            _buildDescription(context)
          ],
        ),
      ),
    );
  }

  Widget _buildStatusListItem(
      {required String status, required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)?.kStatusLabel ?? '',
          style: TextStyle(fontSize: kTextRegular),
        ),
        kSize40.hGap,
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: kMarginMedium + 5, vertical: kMargin5 - 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kMarginMedium2),
              color: kBlackColor.withValues(alpha: 0.12)),
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

  Widget _buildListDetail({required String title, required String value}) {
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
            style:
                TextStyle(fontSize: kTextRegular, fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)?.kDescriptionLabel ?? '',
          style: TextStyle(
              fontFamily: AppData.shared.fontFamily2,
              fontSize: AppData.shared.getMediumFontSize(),
              fontWeight: FontWeight.w700),
        ),
        10.vGap,
        Text(
          pendingData.description?.trim() ?? '',
          style: TextStyle(fontSize: kTextRegular),
        ),
        20.vGap,
        GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: pendingData.attach?.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: kMarginMedium2,
                crossAxisSpacing: kMarginMedium2,
                mainAxisExtent: 216),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () =>
                    showDialogImage(context, pendingData.attach?[index] ?? ''),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: cacheImage(pendingData.attach?[index] ?? ''),
                ),
              );
            }),
      ],
    );
  }
}
