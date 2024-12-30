import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';

import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../utils/images.dart';
import '../../widgets/cache_image.dart';

class ChangeProfilePage extends StatelessWidget {
  ChangeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              kBillingBackgroundImage,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(top: 0, child: ProfileAppbar()),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: kMargin60, left: kMargin80, right: kMargin80),
                child: _buildHeader(context),
              ),
              kMarginMedium2.vGap,
              _buildListView()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
          spacing: kMarginMedium,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: kSize100,
              width: kSize100,
              padding: EdgeInsets.all(kMargin5 - 1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kThirdColor],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Container(
                height: kSize100,
                decoration:
                    BoxDecoration(color: kWhiteColor, shape: BoxShape.circle),
                width: kSize100,
                child: ClipOval(
                    child: cacheImage(
                        'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D')),
              ),
            ),
            InkWell(
              onTap: () => {},
              child: Container(
                height: kSize28,
                width: kSize110,
                padding: EdgeInsets.symmetric(horizontal: kMargin10),
                decoration: BoxDecoration(
                    color: kPrimaryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(kMarginMedium2)),
                child: Center(
                  child: Text(
                    kChangeProfileLabel,
                    style: TextStyle(
                        fontSize: kTextRegular13,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ]),
    );
  }

  final List<String> listItems = [
    kCreatedDateLabel,
    kNameLabel,
    kEmailAddressLabel,
    kPhoneNumberLabel,
    kCityLabel,
    kTownshipLabel,
    kAddressLabel,
    kNoOfPropertyLabel
  ];
  Widget _buildListView() {
    return Column(
      spacing: kMargin12,
      children: listItems.asMap().entries.map((entry) {
        return _buildListDetail(title: entry.value, value: 'value');
      }).toList(),
    );
  }

  Widget _buildListDetail({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: kTextRegular + 1),
          ),
          kSize40.hGap,
          Expanded(
            child: Text(
              value,
              softWrap: true,
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: kTextRegular + 1, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
