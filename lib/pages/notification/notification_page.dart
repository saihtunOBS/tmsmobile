import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/noti_list_item.dart';
import 'package:tmsmobile/pages/home/invoice_detail_page.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        foregroundColor: kWhiteColor,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kPrimaryColor, kThirdColor],
              stops: [0.0, 1.0],
            ),
          ),
          child: Stack(children: [
            Positioned(bottom: kMargin10 + 4, child: _buildHeader())
          ]),
        ),
      ),
      body: Stack(children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            kBillingBackgroundImage,
            fit: BoxFit.fill,
          ),
        ),
        SingleChildScrollView(
          child: Column(children: [
            _buildNewNotiBody(),
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
        )
      ]),
    );
  }

  Widget _buildNewNotiBody() {
    return Column(
      children: [
        16.vGap,
        Text(
          kNewNotificationLabel,
          style: TextStyle(fontSize: kTextRegular2x, color: kPrimaryColor),
        ),
        10.vGap,
        ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => PageNavigator(ctx: context)
                    .nextPage(page: InvoiceDetailPage()),
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

  Widget _buildHeader() {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: kMargin40,
          height: kMargin40,
          margin: EdgeInsets.only(left: kMargin24),
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(kMargin5)),
          child: Center(
            child: Image.asset(kAppLogoImage),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hi, John',
              style: TextStyle(color: kWhiteColor),
            ),
            Text(
              'Good Morning',
              style: TextStyle(color: kWhiteColor),
            )
          ],
        )
      ],
    );
  }
}
