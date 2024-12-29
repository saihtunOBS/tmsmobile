import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/cache_image.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';

class AnnouncementDetailPage extends StatelessWidget {
  const AnnouncementDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kMargin60),
          child: GradientAppBar(
            kBackLabel,
          )),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kMarginMedium2, vertical: kMarginMedium2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: kSize180,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kMarginMedium),
                child: cacheImage(
                    'https://mapartments.co.uk/uploads/transforms/b235c4646ab36ef9ae959de20fa459fc/11257/401_topRenders_b_7abbbb2796f27c91ef535646dc2c5299.webp'),
              ),
            ),
            5.vGap,
            Row(
              spacing: kMarginMedium,
              children: [
                Icon(CupertinoIcons.calendar),
                Text(
                  'Dec 12, 2024',
                  style: TextStyle(
                    fontSize: kTextSmall,fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            kMarginMedium2.vGap,
            Text(
              'New Properties for Rent',
              style: GoogleFonts.crimsonPro(fontSize: kTextRegular24,fontWeight: FontWeight.w700),
            ),
            kMarginMedium2.vGap,
            Text(
              'Lorem ipsum dolor sit amet consectetur. Eget neque gravida tellus vitae quis a. Aliquam a sagittis nibh ipsum. Tincidunt tristique bibendum adipiscing id volutpat lectus. Ullamcorper magna amet nibh venenatis risus. ',
              style: TextStyle(
                fontSize: kTextRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
