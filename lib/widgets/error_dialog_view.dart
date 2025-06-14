import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/auth/login_page.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import 'package:tmsmobile/l10n/app_localizations.dart';

class ErrorDialogView extends StatelessWidget {
  final String? errorMessage;
  final bool? isLogin;
  const ErrorDialogView({super.key, required this.errorMessage, this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      surfaceTintColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(kMarginMedium2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kMarginMedium2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(kMarginMedium2),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Oops...",
              style: TextStyle(
                  fontSize: kTextRegular,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              errorMessage ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: kTextRegular,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  isLogin == true
                      ? PageNavigator(ctx: context)
                          .nextPageOnly(page: LoginPage())
                      : Navigator.of(context).pop();
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [kPrimaryColor, kThirdColor],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(6)),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)?.kOkLabel ?? '',
                      style: TextStyle(
                          color: kBackgroundColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
