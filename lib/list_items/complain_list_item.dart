import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';

class ComplainListItem extends StatelessWidget {
  const ComplainListItem({
    super.key, this.isLast,
  });
  final bool? isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kMargin12,),
      child: Column(
        spacing: kMargin5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kCompliantLabel,
            style: TextStyle(
                fontSize: kTextRegular2x, fontWeight: FontWeight.w700),
          ),
          Text(
            'Lorem ipsum dolor sit amet consectetur. Eget neque gravida tellus vitae quis ar .....',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            softWrap: true,
            style: TextStyle(fontSize: kTextRegular),
          ),
          Row(
            children: [
              Spacer(),
              Container(
                height: kSize28,
                padding: EdgeInsets.symmetric(horizontal: kMargin12),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(kMargin5 + 1)),
                child: Center(
                  child: Text(
                    kViewDetailLabel,
                    style: TextStyle(
                        fontSize: kTextSmall,
                        color: kWhiteColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          ),
          isLast == true ? SizedBox() : Divider()
        ],
      ),
    );
  }
}
