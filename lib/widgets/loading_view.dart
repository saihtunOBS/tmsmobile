import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../utils/dimens.dart';

class LoadingView extends StatelessWidget {
  final Indicator indicator;
  final Color indicatorColor;
  final Color? bgColor;
  const LoadingView(
      {super.key,
      required this.indicator,
      required this.indicatorColor,
      this.bgColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? Colors.black12,
      child: Center(
        child: SizedBox(
          width: kMarginXLarge,
          height: kMarginXLarge,
          child: LoadingIndicator(
            indicatorType: indicator,
            colors: [indicatorColor],
            strokeWidth: 1,
            backgroundColor: Colors.transparent,
            pathBackgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
