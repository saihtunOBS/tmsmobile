import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/bloc/change_password_bloc.dart';
import 'package:tmsmobile/pages/auth/term_and_condition_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar_back.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';
import '../../utils/images.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, required this.isFirstTime});
  final bool isFirstTime;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ChangePasswordBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          excludeHeaderSemantics: true,
          toolbarHeight: kMargin160,
          backgroundColor: Colors.transparent,
          surfaceTintColor: kBackgroundColor,
          automaticallyImplyLeading: false,
          flexibleSpace: SizedBox(
            width: double.infinity,
            child: Stack(fit: StackFit.expand, children: [
              Image.asset(
                kAppBarTopImage,
                fit: BoxFit.cover,
              ),
              Positioned(top: 45, child: AppbarBackView())
            ]),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              const SizedBox(
                height: kMargin195,
              ),
              Center(
                child: SizedBox(
                  height: 89,
                  width: 58,
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
                  widget.isFirstTime == false
                      ? kResetPassword
                      : kChangeYourPasswordLabel,
                  style: GoogleFonts.crimsonPro(
                      fontWeight: FontWeight.w600, fontSize: kTextRegular24),
                ),
              ),
              _buildTextField(
                  title: kNewPasswordLabel,
                  icon: Icon(CupertinoIcons.lock),
                  controller: _passwordController),
              _buildTextField(
                  title: kConfirmPasswordLabel,
                  icon: Icon(CupertinoIcons.lock),
                  controller: _confirmPasswordController),
              const SizedBox(
                height: kMargin5,
              ),
              _buildCheckPassword(),
              const SizedBox(
                height: kMargin24,
              )
            ],
          ),
        ),
        bottomNavigationBar: Stack(alignment: Alignment.center, children: [
          Image.asset(
            kAppBarBottonImage,
            fit: BoxFit.contain,
          ),
          gradientButton(onPress: () {
            PageNavigator(ctx: context).nextPage(page: TermAndConditionPage());
          }),
        ]),
      ),
    );
  }

  Widget _buildCheckPassword() {
    return Selector<ChangePasswordBloc, bool>(
      selector: (context, bloc) => bloc.isMore8character,
      builder: (BuildContext context, value, Widget? child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: kMargin24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                kYourPasswordMustContainLabel.toUpperCase(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: kTextRegular2x),
              ),
              Row(
                spacing: 8,
                children: [
                  Image.asset(
                    kRadioImage,
                    width: 8,
                    height: 8,
                  ),
                  Text(kCharacterLabel)
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Image.asset(
                    kRadioImage,
                    width: 8,
                    height: 8,
                  ),
                  Text(kUppercaseLetterLabel)
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Image.asset(
                    kRadioImage,
                    width: 8,
                    height: 8,
                  ),
                  Text(kOneOrMoreNumberLabel)
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Image.asset(
                    kRadioImage,
                    width: 8,
                    height: 8,
                  ),
                  Text(kOneOrMoreSpecialCharacterLabel)
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(
      {required String title,
      required Icon icon,
      required TextEditingController controller}) {
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
            height: 46,
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
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: title,
                            hintStyle: TextStyle(fontSize: kTextRegular2x)))),
                const SizedBox(
                  width: kMargin5,
                ),

                ///icon
                icon
              ],
            ),
          ),
        ],
      ),
    );
  }
}
