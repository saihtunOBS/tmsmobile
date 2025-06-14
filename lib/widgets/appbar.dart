import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:tmsmobile/utils/colors.dart";
import "package:tmsmobile/utils/dimens.dart";
import 'package:tmsmobile/l10n/app_localizations.dart';
import "../data/app_data/app_data.dart";
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
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        title == AppLocalizations.of(context)?.kCloseLabel
                            ? Icons.close
                            : CupertinoIcons.chevron_back,
                        color: kWhiteColor,
                      )),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: AppData.shared.getRegularFontSize(),
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
  final bool? isProfile;
  const ProfileAppbar({super.key, this.title, this.action, this.isProfile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Image.asset(
            kProfileAppbarImage,
            fit: BoxFit.fill,
            height: kMargin110 - 30,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: EdgeInsets.only(top: kMargin45),
            child: isProfile == true
                ? SizedBox()
                : Center(
                    child: Row(
                      children: [
                        GestureDetector(
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
                                title ??
                                    AppLocalizations.of(context)?.kBackLabel ??
                                    '',
                                style: TextStyle(
                                    fontSize:
                                        AppData.shared.getRegularFontSize(),
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
