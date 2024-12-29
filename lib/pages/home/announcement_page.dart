import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/announcement_list_item.dart';
import 'package:tmsmobile/pages/home/announcement_detail_page.dart';
import 'package:tmsmobile/utils/dimens.dart';

import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../widgets/appbar.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kMargin60),
          child: GradientAppBar(kAnnouncementLabel)),
      body: Stack(
        children: [
          SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            kBillingBackgroundImage,
            fit: BoxFit.fill,
          ),
        ),
          ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: kMarginMedium2,vertical: kMarginMedium2),
          itemCount: 4,
          itemBuilder: (context,index){
          return InkWell(
            onTap: () => PageNavigator(ctx: context).nextPage(page: AnnouncementDetailPage()),
            child: const AnnouncementListItem());
        }),]
      ),
    );
  }
}