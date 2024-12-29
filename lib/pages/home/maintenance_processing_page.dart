import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/strings.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';

class MaintenanceProcessingPage extends StatelessWidget {
  const MaintenanceProcessingPage({super.key});

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
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2,vertical: kMarginMedium2),
      child: Column(
        spacing: kMargin5 - 1,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kProcessingStateLabel,
            style: TextStyle(
                fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
          ),
          Text(
            'We will arrive within 2 day.....',
            style: TextStyle(
                fontSize: kTextRegular,),
          ),
         
        ],
      ),
    );
  }
}
