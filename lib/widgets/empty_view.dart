import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/dimens.dart';

class EmptyView extends StatelessWidget {
  const EmptyView(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subTitle});
  final String imagePath;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: kMargin6,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Image.asset(imagePath),
          ),
          Text(
            title,
            style:
                TextStyle(fontWeight: FontWeight.w600, fontSize: kTextRegular18),
          ),
          Text(
            subTitle,
            style: TextStyle(fontSize: kTextRegular),
          ),
          SizedBox(height: kMargin80,)
        ],
      ),
    );
  }
}
