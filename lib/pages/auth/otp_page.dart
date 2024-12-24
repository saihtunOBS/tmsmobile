import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/pages/auth/change_password_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';
import '../../utils/images.dart';
import '../../widgets/appbar_back.dart';
import 'package:pinput/pinput.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key, this.phone});
  final String? phone;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final pinController = TextEditingController();
  bool isFilled = false;
  final focusNode = FocusNode();
  Timer? _timer;
  int _start = 30;

  @override
  void dispose() {
    pinController.clear();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _start = 30;
    super.initState();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer?.cancel();
          _start = 30;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 140,
        automaticallyImplyLeading: false,
        surfaceTintColor: kBackgroundColor,
        backgroundColor: Colors.transparent,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kMargin24, vertical: kMargin24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              const SizedBox(
                height: 160,
              ),
              Center(
                child: SizedBox(
                  height: 120,
                  width: 80,
                  child: Image.asset(
                    kAppLogoImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                height: kMarginMedium,
              ),
              Text(
                kVerificationCodeLabel,
                style: GoogleFonts.crimsonPro(
                    fontWeight: FontWeight.w600, fontSize: kTextRegular24),
              ),
              Text(
                kSendCodeToNumberLabel,
                style: TextStyle(fontSize: kTextRegular2x),
              ),
              Text(
                widget.phone?.replaceRange(2, 8, "******") ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: kTextRegular2x),
              ),
              _buildPinView(),
              const SizedBox(),
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    kExpireIn,
                    style: TextStyle(fontSize: kTextRegular2x),
                  ),
                  Text(
                    '00:$_start',
                    style: TextStyle(fontSize: kTextRegular2x),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Stack(alignment: Alignment.center, children: [
        Image.asset(
          kAppBarBottonImage,
          fit: BoxFit.fill,
        ),
        gradientButton(onPress: () {
          PageNavigator(ctx: context).nextPage(
              page: ChangePasswordPage(
            isFirstTime: false,
          ));
        }),
        Positioned(
          top: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                kDidNotReceiveCode,
                style: TextStyle(fontSize: kTextRegular2x),
              ),
              TextButton(
                  onPressed: () {
                    if (_start == 30) {
                      startTimer();
                    }
                  },
                  child: Text(
                    kResend,
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.w700),
                  ))
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildPinView() {
    final defaultPinTheme = PinTheme(
      width: 64,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: kInputBackgroundColor,
        borderRadius: BorderRadius.circular(kMarginMedium),
      ),
    );
    final submittedPinTheme = PinTheme(
      width: 64,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
          color: kInputBackgroundColor,
          borderRadius: BorderRadius.circular(kMarginMedium),
          border: Border.all(color: kSecondaryColor)),
    );
    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Pinput(
          controller: pinController,
          length: 6,
          focusNode: focusNode,
          defaultPinTheme: defaultPinTheme,
          submittedPinTheme: submittedPinTheme,
          focusedPinTheme: submittedPinTheme,
          onClipboardFound: (value) {
            pinController.setText(value);
          },
          onCompleted: (pin) {
            setState(() {
              isFilled = true;
            });
          },
          onChanged: (value) {
            setState(() {
              if (pinController.text.length < 6) {
                isFilled = false;
              }
            });
          },
        ),
      ),
    );
  }
}
