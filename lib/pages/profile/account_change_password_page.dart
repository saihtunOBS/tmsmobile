// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/auth_bloc.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/widgets/check_password.dart';
import 'package:tmsmobile/widgets/common_dialog.dart';
import 'package:tmsmobile/widgets/error_dialog_view.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';
import '../../data/app_data/app_data.dart';
import '../../utils/images.dart';
import '../../widgets/loading_view.dart';

class AccountChangePasswordPage extends StatefulWidget {
  const AccountChangePasswordPage({super.key});

  @override
  State<AccountChangePasswordPage> createState() =>
      _AccountChangePasswordPageState();
}

class _AccountChangePasswordPageState extends State<AccountChangePasswordPage> {
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _oldPasswordController = TextEditingController();

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthBloc(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: kBackgroundColor,
            image: DecorationImage(
                image: AssetImage(kBillingBackgroundImage), fit: BoxFit.fill)),
        child: Selector<AuthBloc, bool>(
          selector: (p0, p1) => p1.isLoading,
          builder: (context, isLoading, child) => Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            extendBody: true,
            body: Stack(
              fit: StackFit.expand,
              children: [
                Consumer<AuthBloc>(
                  builder: (context, bloc, child) => SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: kMarginMedium2,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.14,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: kMargin24),
                          child: Text(
                            kChangeYourPasswordLabel,
                            style: TextStyle(
                                fontFamily: AppData.shared.fontFamily2,
                                fontWeight: FontWeight.w600,
                                fontSize: kTextRegular24),
                          ),
                        ),
                        _buildTextField(
                            title: kOldPasswordLabel,
                            icon: bloc.showOldPassword == true
                                ? Icon(CupertinoIcons.eye)
                                : Icon(CupertinoIcons.eye_slash),
                            onTap: () => bloc.onTapOldPassword(),
                            obscure: !bloc.showOldPassword,
                            controller: _oldPasswordController),
                        _buildTextField(
                            title: kNewPasswordLabel,
                            icon: bloc.showNewPassword == true
                                ? Icon(CupertinoIcons.eye)
                                : Icon(CupertinoIcons.eye_slash),
                            controller: _passwordController,
                            obscure: !bloc.showNewPassword,
                            onTap: () => bloc.onTapNewPassword(),
                            bloc: bloc),
                        _buildTextField(
                            title: kConfirmPasswordLabel,
                            icon: bloc.showConfirmPassword == true
                                ? Icon(CupertinoIcons.eye)
                                : Icon(CupertinoIcons.eye_slash),
                            onTap: () => bloc.onTapConfirmPassword(),
                            obscure: !bloc.showConfirmPassword,
                            controller: _confirmPasswordController),
                        const SizedBox(
                          height: kMargin5,
                        ),

                        ///check password
                        CheckPasswordView(),
                      ],
                    ),
                  ),
                ),

                ///appbar
                Positioned(top: 0, child: ProfileAppbar()),

                /// loading
                if (isLoading == true)
                  LoadingView(
                      indicator: Indicator.ballBeat,
                      indicatorColor: kPrimaryColor),
              ],
            ),
            bottomNavigationBar: Consumer<AuthBloc>(
              builder: (context, bloc, child) => SizedBox(
                  height: kBottomBarHeight,
                  child: Center(
                      child: gradientButton(
                          title: kConfirmLabel,
                          onPress: () {
                            if (bloc.checkValidationSuccess() == true) {
                              if (_passwordController.text.trim() !=
                                  _confirmPasswordController.text.trim()) {
                                showCommonDialog(
                                    context: context,
                                    dialogWidget: ErrorDialogView(
                                        errorMessage:
                                            'Password does not match!'));
                              } else {
                                bloc
                                    .onTapContinue(
                                  oldPassword:
                                      _oldPasswordController.text.trim(),
                                  newPassword: _passwordController.text.trim(),
                                )
                                    .then((_) {
                                  Navigator.of(context).pop();
                                }).catchError((error) {
                                  showCommonDialog(
                                      context: context,
                                      dialogWidget: ErrorDialogView(
                                          errorMessage: error.toString()));
                                });
                              }
                            }
                          }))),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String title,
      required Icon icon,
      required TextEditingController controller,
      VoidCallback? onTap,
      bool? obscure,
      AuthBloc? bloc}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMargin24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.nunito(
                fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
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
                        obscureText: obscure ?? true,
                        controller: controller,
                        onChanged: (value) {
                          if (title == kNewPasswordLabel) {
                            bloc?.passwordValidation(passsword: value);
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: title,
                            hintStyle: TextStyle(fontSize: kTextRegular2x)))),
                const SizedBox(
                  width: kMargin5,
                ),

                ///icon
                InkWell(onTap: () => onTap!(), child: icon)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
