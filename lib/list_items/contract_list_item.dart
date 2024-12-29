import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';

class ContractListItem extends StatelessWidget {
  const ContractListItem({
    super.key,
    required this.onPress,
  });
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kMargin50),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
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
                style: GoogleFonts.crimsonPro(
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
                  color: kWhiteColor, borderRadius: BorderRadius.circular(kSize40)),
              child: Center(child: Image.asset(kContractBorderImage)),
            ),
          ),
          Positioned(
            top: -kMargin24,
            left: kMargin50 + kMargin30,
            child: Text(
              'Dec 1, 2024',
              style: TextStyle(fontSize: kTextRegular13),
            ),
          )
        ],
      ),
    );
  }
}
