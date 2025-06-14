import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/booking_list_item.dart';
import 'package:tmsmobile/pages/home/booking_hour_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/l10n/app_localizations.dart';

import '../../utils/dimens.dart';
import '../../utils/images.dart';
import 'booking_section_page.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

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
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kMargin60),
            child: GradientAppBar(
              AppLocalizations.of(context)?.kBookingLabel ?? '',
            )),
        body: ListView.builder(
            itemCount: 4,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(
                horizontal: kMarginMedium2, vertical: kMarginMedium2),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      PageNavigator(ctx: context)
                          .nextPage(page: BookingHourPage());
                    } else {
                      PageNavigator(ctx: context)
                          .nextPage(page: BookingSectionPage());
                    }
                  },
                  child: BookingListItem());
            }),
      ),
    );
  }
}
