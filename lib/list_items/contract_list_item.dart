import 'package:flutter/material.dart';
import 'package:tmsmobile/data/vos/contract_vo.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';

import '../data/app_data/app_data.dart';

class ContractListItem extends StatelessWidget {
  const ContractListItem({
    super.key,
    required this.onPress,
    required this.data,
  });
  final VoidCallback onPress;
  final ContractVO data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kMargin50),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 4),
              color: const Color.fromARGB(255, 165, 165, 165),
              blurRadius: 4.0)
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: onPress,
            child: Container(
              height: 66,
              padding: EdgeInsets.only(
                  top: kMarginMedium2 + 5, left: kMarginMedium2 + 4),
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kPrimaryColor, kThirdColor],
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(kMargin5)),
              child: Text(
                'Condo Sale Contract',
                style: TextStyle(
                    fontFamily: AppData.shared.fontFamily2,
                    fontSize: kTextRegular18,
                    color: kWhiteColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Positioned(
            top: -kSize43,
            left: 20,
            child: Container(
              height: kMargin60,
              width: kMargin60,
              padding: EdgeInsets.only(top: kMargin5),
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(kSize40)),
              child: Center(child: Image.asset(kContractBorderImage)),
            ),
          ),
          Positioned(
            top: -kMarginMedium3,
            left: kMargin50 + kMargin30,
            child: Text(
              DateFormatter.formatDate2(data.createdAt ?? DateTime.now()),
              style: TextStyle(
                  fontSize: kTextRegular13, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
