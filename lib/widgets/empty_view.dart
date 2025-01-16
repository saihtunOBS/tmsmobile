import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/dimens.dart';

import '../data/app_data/app_data.dart';


class EmptyView extends StatelessWidget {
  const EmptyView(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subTitle, this.onPress});
  final String imagePath;
  final String title;
  final String subTitle;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: kMargin6,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: kSize120,
            height: kSize120,
            child: Image.asset(imagePath),
          ),
          Text(
            title,
            style:
                TextStyle(fontWeight: FontWeight.w600, fontSize: AppData.shared.getRegularFontSize()),
          ),
          Text(
            subTitle,
            style: TextStyle(fontSize: kTextRegular),
          ),
          SizedBox(height: kSize80,)
        ],
      ),
    );
  }
}
