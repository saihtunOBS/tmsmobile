import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/auth/forgor_password_page.dart';
import 'package:tmsmobile/pages/nav/nav_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';
import '../../data/app_data/app_data.dart';
import '../../utils/images.dart';

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
    isFirstTime = PersistenceData.shared.getFirstTimeStatus() ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: kMarginMedium2,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(seconds: 5),
              builder: (BuildContext context, value, Widget? child) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: Center(
                child: SizedBox(
                  height: kSize89,
                  width: kSize58,
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
                kLoginToYourAccountLabel,
                style: TextStyle(
                          fontFamily: AppData.shared.fontFamily2,
                    fontWeight: FontWeight.w600, fontSize: kTextRegular24),
              ),
            ),
            _buildTextField(
                title: kPhoneNumberLabel,
                icon: Icon(CupertinoIcons.phone),
                controller: _phoneController),
            _buildTextField(
                title: kPasswordLabel,
                icon: Icon(CupertinoIcons.lock),
                controller: _passwordController),

            ///forgot password
            if (isFirstTime == false)
              Padding(
                padding: const EdgeInsets.only(right: kMargin24),
                child: Row(
                  children: [
                    Spacer(),
                    InkWell(
                        onTap: () {
                          PageNavigator(ctx: context)
                              .nextPage(page: ForgotPasswordPage());
                        },
                        child: Text(
                          kForgotPasswordLabel,
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: kTextRegular2x,
                              fontWeight: FontWeight.w700),
                        ))
                  ],
                ),
              ),
            _buildTermAndCondition()
          ],
        ),
      ),
      bottomNavigationBar: Stack(alignment: Alignment.center, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.21,
          width: double.infinity,
          child: Image.asset(
            kAppBarBottonImage,
            fit: BoxFit.fill,
          ),
        ),
        gradientButton(
            title: isFirstTime == true ? kContinueLabel : kLoginLabel,
            onPress: () {
              Navigator.pushAndRemoveUntil(
                  context, createRoute(NavPage()), (_) => false);
            }),
      ]),
    );
  }

  Widget _buildTermAndCondition() {
    return Row(
      children: [
        SizedBox(
          width: kMargin10,
        ),
        Checkbox(
            value: isSelected,
            onChanged: (value) {
              setState(() {
                isSelected = !isSelected;
              });
            }),
        Text(
          kTermAndConditionLabel,
          style: GoogleFonts.nunito(
              fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
        )
      ],
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
