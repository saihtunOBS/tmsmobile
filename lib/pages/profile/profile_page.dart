import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/profile/account_change_language_page.dart';
import 'package:tmsmobile/pages/profile/account_change_password_page.dart';
import 'package:tmsmobile/pages/profile/change_profile_page.dart';
import 'package:tmsmobile/pages/profile/emergency_contact_page.dart';
import 'package:tmsmobile/pages/profile/household_registration_page.dart';
import 'package:tmsmobile/pages/profile/account_term_and_condition_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/cache_image.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';

import '../../utils/images.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              kBillingBackgroundImage,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              top: 0,
              child: Image.asset(
                kProfileAppbarImage,
                fit: BoxFit.fill,
                height: kMargin110,
                width: MediaQuery.of(context).size.width,
              )),
          Padding(
            padding: EdgeInsets.only(top: kMargin80 + 5),
            child: _buildHeader(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        spacing: kMarginMedium,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: kSize100,
            width: kSize100,
            padding: EdgeInsets.all(kMargin5 - 1),
            decoration: BoxDecoration(
              color: kWhiteColor,
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [kPrimaryColor, kThirdColor],
                stops: [0.0, 1.0],
              ),
            ),
            child: Container(
              height: kSize100,
              decoration:
                  BoxDecoration(color: kWhiteColor, shape: BoxShape.circle),
              width: kSize100,
              child: ClipOval(
                  child: cacheImage(
                      'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D')),
            ),
          ),
          Text(
            'Simon',
            style: GoogleFonts.crimsonPro(
                fontSize: kTextRegular24, fontWeight: FontWeight.w600),
          ),
          Text(
            '098888888888'.replaceRange(3, 8, '*****'),
          ),
          InkWell(
            onTap: () =>
                PageNavigator(ctx: context).nextPage(page: ChangeProfilePage()),
            child: Container(
              height: kSize28,
              width: kSize110,
              padding: EdgeInsets.symmetric(horizontal: kMargin10),
              decoration: BoxDecoration(
                  color: kPrimaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(kMarginMedium2)),
              child: Center(
                child: Text(
                  kViewProfileLabel,
                  style: TextStyle(
                      fontSize: kTextRegular13,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          _buildSetting(context),

          ///logout button
          gradientButton(
              onPress: () {
                showModalBottomSheet(
                    elevation: 0,
                    context: context,
                    builder: (_) => _buildBottomSheet());
              },
              isLogout: true,
              title: kLogoutLabel),
          kMargin110.vGap
        ],
      ),
    );
  }

  final List<String> settings = [
    kChangePasswordLabel,
    kEmergencyContactLabel,
    kHouseholdLabel,
    kTermAndConditionLabel,
    kLanguageLabel,
    kDeleteAccountLabel
  ];
  final List<String> settingIcons = [
    kPasswordIcon,
    kEmergencyIcon,
    kHouseholdIcon,
    kPrivacyIcon,
    kLanguageIcon,
    kDeleteAccountIcon
  ];

  Widget _buildSetting(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: kMargin24),
      child: Column(
        spacing: kMargin5 + 1,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: kMargin5),
            child: Text(
              'Setting',
              style: GoogleFonts.crimsonPro(
                  fontSize: kTextRegular24,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor),
            ),
          ),
          Column(
            spacing: kMargin5 + 1,
            children: settings.asMap().entries.map((entry) {
              return InkWell(
                onTap: () {
                  switch (entry.value) {
                    case kDeleteAccountLabel:
                      showModalBottomSheet(
                          context: context,
                          builder: (_) =>
                              _buildBottomSheet(isDeleteAccount: true));
                    case kChangePasswordLabel:
                      PageNavigator(ctx: context)
                          .nextPage(page: AccountChangePasswordPage());
                    case kLanguageLabel:
                      PageNavigator(ctx: context)
                          .nextPage(page: AccountChangeLanguagePage());
                    case kEmergencyContactLabel:
                      PageNavigator(ctx: context)
                          .nextPage(page: EmergencyContactPage());
                    case kHouseholdLabel:
                      PageNavigator(ctx: context)
                          .nextPage(page: HouseholdRegistrationPage());
                    case kTermAndConditionLabel:
                      PageNavigator(ctx: context)
                          .nextPage(page: AccountTermAndConditionPage());
                      break;

                    default:
                  }
                },
                child: _buildSettingChild(
                    title: entry.value, image: settingIcons[entry.key]),
              );
            }).toList(),
          ),
          10.vGap,
        ],
      ),
    );
  }

  Widget _buildSettingChild({required String title, required String image}) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: Row(
        children: [
          Image.asset(
            image,
            width: 36,
            height: 36,
          ),
          10.hGap,
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: kTextRegular2x,
                color: kPrimaryColor),
          ),
          Spacer(),
          Icon(
            CupertinoIcons.chevron_right,
            size: kMarginMedium2,
          )
        ],
      ),
    );
  }

  Widget _buildBottomSheet({bool? isDeleteAccount}) {
    return Container(
      height: 233,
      width: double.infinity,
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kMargin40),
              topRight: Radius.circular(kMargin40))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            isDeleteAccount == true ? kDeleteAccountIcon : kLogoutIcon,
            width: kMargin52 + 2,
            height: kMargin52 + 2,
          ),
          kMarginMedium.vGap,
          Text(
            isDeleteAccount == true ? kDeleteAccountLabel : kConfirmLogoutLabel,
            style: TextStyle(
                fontSize: kTextRegular3x,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMargin24),
            child: Text(
              isDeleteAccount == true
                  ? kAreYouSureDeleteAccountLabel
                  : kAreYouSureLogoutLabel,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: kTextRegular2x),
            ),
          ),
          kMarginMedium2.vGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 38,
                width: 98,
                decoration: BoxDecoration(
                    color: kGreyColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(kMargin6)),
                child: Center(
                  child: Text(kCancelLabel),
                ),
              ),
              Container(
                height: 38,
                width: 98,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(kMargin6)),
                child: Center(
                  child: Text(
                    kOkLabel,
                    style: TextStyle(color: kWhiteColor),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
