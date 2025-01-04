import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/change_password_bloc.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/widgets/check_password.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';
import '../../data/app_data/app_data.dart';
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
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: kBackgroundColor,
            image: DecorationImage(
                image: AssetImage(kBillingBackgroundImage), fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Consumer<ChangePasswordBloc>(
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
                          icon: Icon(CupertinoIcons.lock),
                          controller: _oldPasswordController),
                      _buildTextField(
                          title: kNewPasswordLabel,
                          icon: Icon(CupertinoIcons.lock),
                          controller: _passwordController,
                          bloc: bloc),
                      _buildTextField(
                          title: kConfirmPasswordLabel,
                          icon: Icon(CupertinoIcons.lock),
                          controller: _confirmPasswordController),
                      const SizedBox(
                        height: kMargin5,
                      ),

                      ///check password
                      CheckPasswordView()
                    ],
                  ),
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
      ),
    );
  }

  Widget _buildTextField(
      {required String title,
      required Icon icon,
      required TextEditingController controller,
      ChangePasswordBloc? bloc}) {
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
                icon
              ],
            ),
          ),
        ],
      ),
    );
  }
}
