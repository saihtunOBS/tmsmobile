import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/strings.dart';

import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';

class SubmitComplainPage extends StatelessWidget {
  SubmitComplainPage({super.key});

  final _complainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kMargin60),
          child: GradientAppBar(
            kBackLabel,
          )),
      body: _buildTextField(controller: _complainController),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2,vertical: kMarginMedium2),
      child: Column(
        spacing: kMargin5 - 1,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 3,
            children: [
              Text(
                kCompliantLabel,
                style: TextStyle(
                    fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
              ),
              Text(
                '*',
                style: TextStyle(color: Colors.red, fontSize: kTextRegular3x),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kMargin10),
            decoration: BoxDecoration(
                color: kInputBackgroundColor,
                borderRadius: BorderRadius.circular(kMarginMedium)),
            child: TextField(
              maxLines: 15,
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: kWriteComplainLabel),
            ),
          )
        ],
      ),
    );
  }
}
