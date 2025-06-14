import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/l10n/app_localizations.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';

class AppbarBackView extends StatelessWidget {
  const AppbarBackView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            AppLocalizations.of(context)?.kBackLabel ?? '',
            style: TextStyle(
                color: kWhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: kTextRegular),
          )
        ],
      ),
    );
  }
}
