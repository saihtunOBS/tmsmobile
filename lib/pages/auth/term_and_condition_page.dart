import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';

class TermAndConditionPage extends StatelessWidget {
  const TermAndConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: GradientAppBar(kCloseLabel)),
      backgroundColor: kBackgroundColor,
    );
  }
}
