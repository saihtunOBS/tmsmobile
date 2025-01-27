import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';

import '../data/app_data/app_data.dart';
import '../data/persistance_data/persistence_data.dart';

class HomeListItem extends StatelessWidget {
  const HomeListItem(
      {super.key,
      required this.backgroundColor,
      required this.label,
      required this.imageLogo});
  final Color backgroundColor;
  final String label;
  final String imageLogo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 5), color: 
                    kGreyColor, blurRadius: 6.0)
              ],
              color: backgroundColor,
              borderRadius: BorderRadius.circular(kMargin5)),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: PersistenceData.shared.getLocale() == 'my'
                      ? AppData.shared.fontFamily3
                      : AppData.shared.fontFamily2,
                  fontSize: AppData.shared.getRegularFontSize(),
                  color: kWhiteColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: -kSize40 + 5,
          left: 20,
          child: Container(
            height: kMargin60 - 3,
            width: kMargin60 - 3,
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(kSize40)),
            child: Center(
              child: Container(
                height: kMargin40,
                width: kMargin40,
                padding: EdgeInsets.all(kMargin5 + 2),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(
                            0,
                            3,
                          ),
                          blurRadius: 8.2,
                          color: kGreyColor)
                    ],
                    border: Border.all(color: backgroundColor, width: 2),
                    shape: BoxShape.circle),
                child: Image.asset(
                  imageLogo,
                  width: kMarginMedium3,
                  height: kMarginMedium3,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
