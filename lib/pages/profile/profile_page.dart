// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/profile_bloc.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/auth/login_page.dart';
import 'package:tmsmobile/pages/profile/account_change_language_page.dart';
import 'package:tmsmobile/pages/profile/account_change_password_page.dart';
import 'package:tmsmobile/pages/profile/account_term_and_condition_page.dart';
import 'package:tmsmobile/pages/profile/change_profile_page.dart';
import 'package:tmsmobile/pages/profile/emergency_contact_page.dart';
import 'package:tmsmobile/pages/profile/household_registration_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/widgets/cache_image.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tmsmobile/widgets/loading_view.dart';

import '../../data/app_data/app_data.dart';
import '../../utils/images.dart';
import '../../widgets/common_dialog.dart';
import '../../widgets/error_dialog_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileBloc(context: context),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Consumer<ProfileBloc>(
          builder: (context, bloc, child) => Stack(
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
                  child: ProfileAppbar(
                    isProfile: true,
                  )),
              Padding(
                padding: EdgeInsets.only(top: kMargin60),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: kMarginMedium,
                      children: [
                        _buildHeader(context),
                        3.vGap,
                        _buildSetting(context, bloc),

                        ///logout button
                        gradientButton(
                            onPress: () {
                              showModalBottomSheet(
                                  elevation: 0,
                                  context: context,
                                  builder: (_) => _buildLogoutBottomSheet(
                                      context: context, bloc: bloc));
                            },
                            context: context,
                            isLogout: true,
                            title: AppLocalizations.of(context)?.kLogoutLabel),
                        80.vGap
                      ]),
                ),
              ),

              ///loading
              if (bloc.isLoading == true) LoadingView()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Consumer<ProfileBloc>(
      builder: (context, bloc, child) => Column(
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
                      PersistenceData.shared.getUser()?.photo ?? '')),
            ),
          ),
          Text(
            PersistenceData.shared.getUser()?.tenantName ?? '****',
            style: TextStyle(
                fontFamily: AppData.shared.fontFamily2,
                fontSize: kTextRegular24,
                fontWeight: FontWeight.w600),
          ),
          Text(
            PersistenceData.shared
                    .getUser()
                    ?.phoneNumber
                    ?.replaceRange(3, 8, '*****') ??
                '****',
          ),
          Consumer<ProfileBloc>(
            builder: (context, bloc, child) => GestureDetector(
              onTap: () => PageNavigator(ctx: context)
                  .nextPage(page: ChangeProfilePage())
                  .whenComplete(() => bloc.getUser()),
              child: FittedBox(
                child: Container(
                  height: kSize28,
                  padding: EdgeInsets.symmetric(horizontal: kMargin10),
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(kMarginMedium2)),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)?.kViewProfileLabel ?? '',
                      style: TextStyle(
                          fontSize: AppData.shared.getSmallXFontSize(),
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSetting(BuildContext context, ProfileBloc bloc) {
    final List<String> settings = [
      AppLocalizations.of(context)?.kChangePasswordLabel ?? '',
      AppLocalizations.of(context)?.kEmergencyContactLabel ?? '',
      AppLocalizations.of(context)?.kHouseholdLabel ?? "",
      AppLocalizations.of(context)?.kTermAndConditionLabel ?? '',
      AppLocalizations.of(context)?.kLanguageLabel ?? '',
      AppLocalizations.of(context)?.kDeleteAccountLabel ?? ''
    ];
    final List<String> settingIcons = [
      kPasswordIcon,
      kEmergencyIcon,
      kHouseholdIcon,
      kPrivacyIcon,
      kLanguageIcon,
      kDeleteAccountIcon
    ];
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
              AppLocalizations.of(context)?.kSettingLabel ?? '',
              style: TextStyle(
                  fontFamily: AppData.shared.fontFamily2,
                  fontSize: AppData.shared.getExtraFontSize(),
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor),
            ),
          ),
          Column(
            spacing: kMargin5 + 1,
            children: settings.asMap().entries.map((entry) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  switch (entry.key) {
                    case 5:
                      showModalBottomSheet(
                          context: context,
                          builder: (_) => _buildLogoutBottomSheet(
                              isDeleteAccount: true,
                              context: context,
                              bloc: bloc));
                    case 0:
                      PageNavigator(ctx: context)
                          .nextPage(page: AccountChangePasswordPage());
                    case 1:
                      PageNavigator(ctx: context)
                          .nextPage(page: EmergencyContactPage());
                    case 2:
                      PageNavigator(ctx: context)
                          .nextPage(page: HouseholdRegistrationPage());
                    case 3:
                      PageNavigator(ctx: context)
                          .nextPage(page: AccountTermAndConditionPage());
                    case 4:
                      PageNavigator(ctx: context)
                          .nextPage(page: AccountChangeLanguagePage());
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
                fontSize: kTextRegular,
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

  Widget _buildLogoutBottomSheet({
    bool? isDeleteAccount,
    ProfileBloc? bloc,
    BuildContext? context,
  }) {
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
            isDeleteAccount == true
                ? AppLocalizations.of(context!)?.kDeleteAccountLabel ?? ''
                : AppLocalizations.of(context!)?.kConfirmLogoutLabel ?? '',
            style: TextStyle(
                fontSize: AppData.shared.getMediumFontSize(),
                fontWeight: FontWeight.w600,
                color: kPrimaryColor),
          ),
          3.vGap,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMargin24),
            child: Text(
              isDeleteAccount == true
                  ? AppLocalizations.of(context)
                          ?.kAreYouSureDeleteAccountLabel ??
                      ''
                  : AppLocalizations.of(context)?.kAreYouSureLogoutLabel ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: kTextRegular,
              ),
            ),
          ),
          kMarginMedium2.vGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 38,
                  width: 98,
                  decoration: BoxDecoration(
                      color: kGreyColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(kMargin6)),
                  child: Center(
                    child:
                        Text(AppLocalizations.of(context)?.kCancelLabel ?? ''),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (isDeleteAccount == true) {
                    // bloc
                    //     ?.onTapDelete()
                    //     .then((_) => PageNavigator(ctx: context)
                    //         .nextPageOnly(page: LoginPage()))
                    //     .catchError((error) {
                    //   showCommonDialog(
                    //       context: context,
                    //       dialogWidget:
                    //           ErrorDialogView(errorMessage: error.toString()));
                    // });
                  } else {
                    bloc?.onTapLogout().then((_) async {
                      await PersistenceData.shared.clearToken();
                      await PersistenceData.shared.clearUserData();
                      PageNavigator(ctx: context)
                          .nextPageOnly(page: LoginPage());
                    }).catchError((error) async {
                      await PersistenceData.shared.clearToken();
                      await PersistenceData.shared.clearUserData();
                      PageNavigator(ctx: context)
                          .nextPageOnly(page: LoginPage());
                      // showCommonDialog(
                      //     context: context,
                      //     dialogWidget:
                      //         ErrorDialogView(errorMessage: error.toString()));
                    });
                  }
                },
                child: Container(
                  height: 38,
                  width: 98,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(kMargin6)),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)?.kOkLabel ?? '',
                      style: TextStyle(color: kWhiteColor),
                    ),
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
