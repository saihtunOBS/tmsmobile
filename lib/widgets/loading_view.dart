import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tmsmobile/utils/colors.dart';

class LoadingView extends StatelessWidget {
  final Color? bgColor;
  const LoadingView({super.key, this.bgColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? Colors.black12,
      child: Center(
        child: LoadingAnimationWidget.flickr(
            leftDotColor: kThirdColor, rightDotColor: kBlackColor, size: 20),
      ),
    );
  }
}
