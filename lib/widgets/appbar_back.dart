import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';

class AppbarBackView extends StatelessWidget {
  const AppbarBackView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Row(
        children: [
          SizedBox(
            height: kSize50,
            width: kSize50,
            child: Center(
              child: Icon(
                CupertinoIcons.chevron_back,
                color: kWhiteColor,
              ),
            ),
          ),
          Text(
            kBackLabel,
            style: TextStyle(
                color: kWhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: kTextRegular2x),
          )
        ],
      ),
    );
  }
}


