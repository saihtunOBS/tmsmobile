import 'package:flutter/material.dart';
import 'package:tmsmobile/data/vos/billing_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/noti_list_item.dart';
import 'package:tmsmobile/pages/home/invoice_detail_page.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/appbar_header.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/app_data/app_data.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: kBackgroundColor,
          image: DecorationImage(
              image: AssetImage(kBillingBackgroundImage), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          foregroundColor: kWhiteColor,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: AppbarHeader(),
          flexibleSpace: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimaryColor, kThirdColor],
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            _buildNewNotiBody(context),
            ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    vertical: kMarginMedium2, horizontal: kMarginMedium2),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: index == 1 ? kMargin75 : kMargin10),
                        child: NotiListItem(),
                      ),
                    ],
                  );
                }),
          ]),
        ),
      ),
    );
  }

  Widget _buildNewNotiBody(BuildContext context) {
    return Column(
      children: [
        kMarginMedium2.vGap,
        Text(
          AppLocalizations.of(context)?.kNewNotificationLabel ?? '',
          style: TextStyle(
              fontSize: AppData.shared.getSmallFontSize(),
              color: kPrimaryColor),
        ),
        10.vGap,
        ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
            itemBuilder: (context, index) {
              return InkWell(
                // onTap: () => PageNavigator(ctx: context)
                //     .nextPage(page: InvoiceDetailPage(billingData: BillingVO(),)),
                child: Padding(
                  padding: EdgeInsets.only(bottom: kMargin10),
                  child: NotiListItem(),
                ),
              );
            }),
        5.vGap,
        Container(
          height: 1,
          width: double.infinity,
          color: kGreyColor,
          margin: EdgeInsets.symmetric(horizontal: kMargin24),
        ),
        5.vGap,
      ],
    );
  }
}
