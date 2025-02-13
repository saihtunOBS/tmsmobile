// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/login_bloc.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/auth/change_password_page.dart';
import 'package:tmsmobile/pages/auth/forgor_password_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import '../../data/app_data/app_data.dart';
import '../../utils/images.dart';
import '../../widgets/common_dialog.dart';
import '../../widgets/error_dialog_view.dart';
import '../nav/nav_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isSelected = false;
  bool? isFirstTime;

  @override
  void initState() {
    timeDilation = 1.5;
    isFirstTime = PersistenceData.shared.getFirstTimeStatus() ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LogInBloc(),
      child: Material(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            backgroundColor: kBackgroundColor,
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height * 0.21,
              surfaceTintColor: kBackgroundColor,
              backgroundColor: Colors.transparent,
              flexibleSpace: Image.asset(
                kAppBarTopImage,
                fit: BoxFit.fill,
              ),
            ),
            body: Selector<LogInBloc?, bool?>(
              selector: (context, bloc) => bloc?.isLoading,
              builder: (context, isLoading, child) => Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: kMarginMedium2,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Center(
                        child: SizedBox(
                          height: kSize89,
                          width: kSize58,
                          child: Hero(
                            tag: 'animate',
                            child: Image.asset(
                              kAppLogoImage,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kMarginMedium,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: kMargin24),
                        child: Text(
                          AppLocalizations.of(context)
                                  ?.kLoginToYourAccountLabel ??
                              '',
                          style: TextStyle(
                              fontFamily: AppData.shared.fontFamily2,
                              fontWeight: FontWeight.w600,
                              fontSize: AppData.shared.getExtraFontSize()),
                        ),
                      ),
                      _buildTextField(
                          title:
                              AppLocalizations.of(context)?.kPhoneNumberLabel ??
                                  '',
                          icon: Icon(CupertinoIcons.phone),
                          controller: _phoneController,
                          onTap: () {},
                          isNumber: true),
                      Consumer<LogInBloc>(
                        builder: (context, bloc, child) => _buildTextField(
                            title:
                                AppLocalizations.of(context)?.kPasswordLabel ??
                                    '',
                            onTap: bloc.onTapShowPassword,
                            icon: bloc.showPassword == true
                                ? Icon(CupertinoIcons.eye)
                                : Icon(CupertinoIcons.eye_slash),
                            obseure: !bloc.showPassword,
                            controller: _passwordController),
                      ),

                      ///forgot password
                      if (isFirstTime == false)
                        Padding(
                          padding: const EdgeInsets.only(right: kMargin24),
                          child: Row(
                            children: [
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    PageNavigator(ctx: context)
                                        .nextPage(page: ForgotPasswordPage());
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)
                                            ?.kForgotPasswordLabel ??
                                        '',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize:
                                            kTextRegular,
                                        fontWeight: FontWeight.w700),
                                  ))
                            ],
                          ),
                        ),
                      if (isFirstTime == true) _buildTermAndCondition()
                    ],
                  ),
                ),

                /// loading
                if (isLoading == true)
                  LoadingView(
                      ),
              ]),
            ),
            bottomNavigationBar: Consumer<LogInBloc>(
              builder: (context, bloc, child) =>
                  Stack(alignment: Alignment.center, children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.21,
                  width: double.infinity,
                  child: Image.asset(
                    kAppBarBottonImage,
                    fit: BoxFit.fill,
                  ),
                ),
                AnimatedOpacity(
                  opacity: bloc.isAgreeTermAndCondition == false ? 0.5 : 1,
                  duration: Duration(milliseconds: 200),
                  child: gradientButton(
                      title: isFirstTime == true
                          ? AppLocalizations.of(context)?.kContinueLabel
                          : AppLocalizations.of(context)?.kLoginLabel,
                      onPress: () {
                        if (bloc.isAgreeTermAndCondition == true) {
                          bloc
                              .onTapSignIn(_phoneController.text.trim(),
                                  _passwordController.text.trim())
                              .then((value) {
                            if (value.status == true) {
                              if (value.data?.verify == 1) {
                                PersistenceData.shared.saveFirstTime(false);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    createRoute(NavPage(), duration: 500),
                                    (route) => false);
                              } else {
                                PageNavigator(ctx: context).nextPage(
                                    page: ChangePasswordPage(
                                        isChangePassword: true));
                              }
                            }
                          }).catchError((error) {
                            showCommonDialog(
                                context: context,
                                dialogWidget: ErrorDialogView(
                                    errorMessage: error.toString()));
                          });
                        }
                      },
                      context: context),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTermAndCondition() {
    return Consumer<LogInBloc>(
      builder: (context, bloc, child) => Row(
        children: [
          SizedBox(
            width: kMargin10,
          ),
          Checkbox(
              value: bloc.isAgreeTermAndCondition,
              onChanged: (value) {
                bloc.onCheckTermAndConditon(value ?? false);
              }),
          Text(
            AppLocalizations.of(context)?.kTermAndConditionLabel ?? '',
            style: GoogleFonts.nunito(
                fontSize: kTextRegular,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required String title,
      required Icon icon,
      required TextEditingController controller,
      bool? obseure,
      VoidCallback? onTap,
      bool? isNumber}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMargin24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.nunito(
              fontSize: kTextRegular,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            height: kSize46,
            padding: EdgeInsets.symmetric(horizontal: kMargin24),
            width: double.infinity,
            decoration: BoxDecoration(
                color: kInputBackgroundColor,
                borderRadius: BorderRadius.circular(kMarginMedium)),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                        obscureText: obseure ?? false,
                        keyboardType: isNumber == true
                            ? TextInputType.phone
                            : TextInputType.text,
                        controller: controller,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: title,
                            hintStyle: TextStyle(
                                fontSize: kTextRegular)))),
                const SizedBox(
                  width: kMargin5,
                ),

                ///icon
                GestureDetector(onTap: () => onTap!(), child: icon)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
