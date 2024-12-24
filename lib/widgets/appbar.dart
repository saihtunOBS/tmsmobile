import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:tmsmobile/utils/colors.dart";
import "package:tmsmobile/utils/strings.dart";

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 60.0;

  const GradientAppBar(this.title, {super.key});

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
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(title == kCloseLabel ? Icons.close : CupertinoIcons.chevron_back,color: kWhiteColor,)),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
