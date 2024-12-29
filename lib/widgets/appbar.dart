import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:tmsmobile/utils/colors.dart";
import "package:tmsmobile/utils/dimens.dart";
import "package:tmsmobile/utils/strings.dart";

import "../utils/images.dart";

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = kMargin60;
  final Widget? action;
  const GradientAppBar(this.title, {super.key, this.action});

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [kPrimaryColor, kThirdColor],
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Center(
        child: Row(
          children: [
            InkWell(
              onTap: ()=> Navigator.pop(context),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        title == kCloseLabel
                            ? Icons.close
                            : CupertinoIcons.chevron_back,
                        color: kWhiteColor,
                      )),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: kTextRegular18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            ///action button
            Spacer(),
            action ?? SizedBox()
          ],
        ),
      ),
    );
  }
}

class ProfileAppbar extends StatelessWidget {
  final String? title;
  final Widget? action;
  const ProfileAppbar({super.key, this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Image.asset(
            kProfileAppbarImage,
            fit: BoxFit.fill,
            height: kMargin110,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.only(top: kMargin60 + 5),
            child: Center(
              child: Row(
                children: [
                  InkWell(
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
                          title ?? kBackLabel,
                          style: TextStyle(
                              fontSize: kTextRegular18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
              
                  ///action button
                  Spacer(),
                  action ?? SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
