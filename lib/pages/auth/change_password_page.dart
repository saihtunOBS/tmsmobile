// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/auth_bloc.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/auth/login_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/appbar_back_view.dart';
import 'package:tmsmobile/widgets/check_password.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';
import '../../data/app_data/app_data.dart';
import '../../data/persistance_data/persistence_data.dart';
import '../../utils/images.dart';
import '../../widgets/common_dialog.dart';
import '../../widgets/error_dialog_view.dart';
import '../../widgets/loading_view.dart';
import 'package:tmsmobile/l10n/app_localizations.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage(
      {super.key, required this.isChangePassword, this.token});
  final bool isChangePassword;
  final String? token;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          excludeHeaderSemantics: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.21,
          backgroundColor: Colors.transparent,
          surfaceTintColor: kBackgroundColor,
          automaticallyImplyLeading: false,
          flexibleSpace: SizedBox(
            width: double.infinity,
            child: Stack(children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  kAppBarTopImage,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(top: kSize45, child: AppbarBackView())
            ]),
          ),
        ),
        body: Selector<AuthBloc, bool>(
          selector: (p0, p1) => p1.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
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
                        child: Image.asset(
                          kAppLogoImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: kMarginMedium,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: kMargin24),
                      child: Text(
                        widget.isChangePassword == false
                            ? AppLocalizations.of(context)?.kResetPassword ?? ''
                            : AppLocalizations.of(context)
                                    ?.kChangeYourPasswordLabel ??
                                '',
                        style: TextStyle(
                            fontFamily: AppData.shared.fontFamily2,
                            fontWeight: FontWeight.w600,
                            fontSize: AppData.shared.getExtraFontSize()),
                      ),
                    ),
                    Consumer<AuthBloc>(
                      builder: (context, bloc, child) => _buildTextField(
                          title:
                              AppLocalizations.of(context)?.kNewPasswordLabel ??
                                  '',
                          icon: bloc.showNewPassword == true
                              ? Icon(CupertinoIcons.eye)
                              : Icon(CupertinoIcons.eye_slash),
                          bloc: bloc,
                          onTap: bloc.onTapNewPassword,
                          obseure: !bloc.showNewPassword,
                          controller: _passwordController),
                    ),
                    Consumer<AuthBloc>(
                      builder: (context, bloc, child) => _buildTextField(
                          title: AppLocalizations.of(context)
                                  ?.kConfirmPasswordLabel ??
                              '',
                          icon: bloc.showConfirmPassword == true
                              ? Icon(CupertinoIcons.eye)
                              : Icon(CupertinoIcons.eye_slash),
                          bloc: bloc,
                          onTap: bloc.onTapConfirmPassword,
                          obseure: !bloc.showConfirmPassword,
                          controller: _confirmPasswordController),
                    ),
                    Consumer<AuthBloc>(
                      builder: (context, bloc, child) => AnimatedSize(
                        duration: Duration(milliseconds: 100),
                        child: Container(
                          height: bloc.animatedSize,
                          margin: EdgeInsets.symmetric(horizontal: kMargin24),
                          child: Text(
                            AppLocalizations.of(context)
                                    ?.kPasswordCriteiraLabel ??
                                '',
                            style: TextStyle(
                                fontSize: AppData.shared.getSmallXFontSize(),
                                color: kRedColor),
                          ),
                        ),
                      ),
                    ),
                    CheckPasswordView(),
                    const SizedBox(
                      height: kMargin110,
                    )
                  ],
                ),
              ),

              ///
              if (isLoading == true) LoadingView(),
            ],
          ),
        ),
        bottomNavigationBar: Consumer<AuthBloc>(
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
            gradientButton(
                onPress: () {
                  if (bloc.checkValidationSuccess() == true) {
                    if (_passwordController.text.trim() !=
                        _confirmPasswordController.text.trim()) {
                      showCommonDialog(
                          context: context,
                          dialogWidget: ErrorDialogView(
                              errorMessage: AppLocalizations.of(context)
                                  ?.kPasswordDoesNotMatchLabel));
                    } else {
                      bloc
                          .onTapResetPassword(
                              newPassword: _passwordController.text.trim(),
                              confirmPassword:
                                  _confirmPasswordController.text.trim(),
                              authToken: widget.token)
                          .then((_) {
                        PersistenceData.shared.saveFirstTime(false);
                        if (widget.isChangePassword == true) {
                          Navigator.of(context).pop();
                        } else {
                          PageNavigator(ctx: context)
                              .nextPageOnly(page: LoginPage());
                        }
                      }).catchError(
                        (error) {
                          showCommonDialog(
                              context: context,
                              dialogWidget: ErrorDialogView(
                                  errorMessage: error.toString()));
                        },
                      );
                    }
                  }
                },
                context: context),
          ]),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String title,
      required Icon icon,
      AuthBloc? bloc,
      bool? obseure,
      VoidCallback? onTap,
      required TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMargin24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.nunito(
                fontSize: kTextRegular, fontWeight: FontWeight.w600),
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
                        controller: controller,
                        obscureText: obseure ?? false,
                        onChanged: (value) {
                          if (title ==
                              AppLocalizations.of(context)?.kNewPasswordLabel) {
                            bloc?.passwordValidation(passsword: value);
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: title,
                            hintStyle: TextStyle(fontSize: kTextRegular)))),
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
