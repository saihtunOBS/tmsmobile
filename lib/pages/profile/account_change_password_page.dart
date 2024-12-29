import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/change_password_bloc.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';
import '../../utils/images.dart';

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
      create: (BuildContext context) => ChangePasswordBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Stack(
          fit: StackFit.passthrough,
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                kBillingBackgroundImage,
                fit: BoxFit.fill,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: kMarginMedium2,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.16,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kMargin24),
                    child: Text(
                      kChangeYourPasswordLabel,
                      style: GoogleFonts.crimsonPro(
                          fontWeight: FontWeight.w600,
                          fontSize: kTextRegular24),
                    ),
                  ),
                  _buildTextField(
                      title: kOldPasswordLabel,
                      icon: Icon(CupertinoIcons.lock),
                      controller: _oldPasswordController),
                  _buildTextField(
                      title: kConfirmPasswordLabel,
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
                ],
              ),
            ),

            ///appbar
            Positioned(top: 0, child: ProfileAppbar()),
          ],
        ),
        bottomNavigationBar: SizedBox(
            height: kBottomBarHeight,
            child: Center(child: gradientButton(onPress: () {}))),
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
            spacing: kMarginMedium,
            children: [
              Text(
                kYourPasswordMustContainLabel.toUpperCase(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: kTextRegular2x),
              ),
              Row(
                spacing: kMarginMedium,
                children: [
                  Image.asset(
                    kRadioImage,
                    width: kMarginMedium,
                    height: kMarginMedium,
                  ),
                  Text(kCharacterLabel)
                ],
              ),
              Row(
                spacing: kMarginMedium,
                children: [
                  Image.asset(
                    kRadioImage,
                    width: kMarginMedium,
                    height: kMarginMedium,
                  ),
                  Text(kUppercaseLetterLabel)
                ],
              ),
              Row(
                spacing: kMarginMedium,
                children: [
                  Image.asset(
                    kRadioImage,
                    width: kMarginMedium,
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
                    width: kMarginMedium,
                    height: kMarginMedium,
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
