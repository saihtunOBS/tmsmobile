import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/booking_list_item.dart';
import 'package:tmsmobile/pages/home/booking_select_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/widgets/appbar.dart';

import '../../utils/dimens.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kMargin60),
          child: GradientAppBar(
            'Booking',
          )),
      body: ListView.builder(
          itemCount: 4,
          padding: EdgeInsets.symmetric(
              horizontal: kMarginMedium2, vertical: kMarginMedium2),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  PageNavigator(ctx: context)
                      .nextPage(page: BookingSelectPage());
                },
                child: BookingListItem());
          }),
    );
  }
}
