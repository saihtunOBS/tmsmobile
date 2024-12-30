import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/cache_image.dart';

import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';

class MaintenancePendingPage extends StatelessWidget {
  const MaintenancePendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kMargin60),
          child: GradientAppBar(
            kDetailLabel,
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
              spacing: kMargin12,
              children: [
                _buildListDetail(title: kIDLabel, value: 'value'),
                _buildListDetail(title: kDateLabel, value: 'value'),
                _buildListDetail(title: kTenantNameLabel, value: 'value'),
                _buildListDetail(title: kRoomShopNameLabel, value: 'value'),
                _buildListDetail(title: kTypeOfIssueLabel, value: 'value'),
                _buildStatusListItem(status: 'Pending'),
                _buildDescription(context)
              ],
            ),
          ),
          10.vGap
        ],
      ),
    );
  }

  Widget _buildStatusListItem({required String status}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          kStatusLabel,
          style: TextStyle(fontSize: kTextRegular),
        ),
        kSize40.hGap,
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: kMarginMedium, vertical: kMargin5),
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
          kDescriptionLabel,
          style: GoogleFonts.crimsonPro(
            fontSize: kTextRegular3x,fontWeight: FontWeight.w700
          ),
        ),
        10.vGap,
        Text(
          'Lorem ipsum dolor sit amet consectetur. Eget neque gravida tellus vitae quis a. Aliquam a sagittis nibh ipsum. Tincidunt tristique bibendum adipiscing id volutpat lectus. Ullamcorper magna amet nibh venenatis risus. ',
          style: TextStyle(fontSize: kTextRegular),
        ),
        kMarginMedium2.vGap,
        GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 2,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: kMarginMedium2,
                crossAxisSpacing: kMarginMedium2,
                mainAxisExtent: 216),
            itemBuilder: (context, index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: cacheImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/23rd_St_6th_Av_19_-_Chelsea_Stratus.jpg/640px-23rd_St_6th_Av_19_-_Chelsea_Stratus.jpg'),
              );
            })
      ],
    );
  }
}
