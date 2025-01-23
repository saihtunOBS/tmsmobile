// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/auth_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/auth/change_password_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/common_dialog.dart';
import 'package:tmsmobile/widgets/error_dialog_view.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import '../../data/app_data/app_data.dart';
import '../../utils/images.dart';
import '../../widgets/appbar_back.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key, this.phone, this.token});
  final String? phone;
  final String? token;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final pinController = TextEditingController();
  bool isFilled = false;
  final focusNode = FocusNode();
  Timer? _timer;
  int _start = 300;

  String token = '';

  @override
  void dispose() {
    pinController.clear();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _start = 300;
    startTimer();
    token = widget.token ?? '';
    super.initState();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer?.cancel();
          _start = 300;
        }
      });
    });
  }

  String get timerText {
    final minutes = (_start ~/ 60).toString().padLeft(2, '0');
    final seconds = (_start % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.21,
          automaticallyImplyLeading: false,
          surfaceTintColor: kBackgroundColor,
          backgroundColor: Colors.transparent,
          flexibleSpace: SizedBox(
            width: double.infinity,
            child: Stack( children: [
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
        body: Consumer<AuthBloc>(
          builder: (context, bloc, child) => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kMargin24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      kMarginMedium2.vGap,
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
                      kSize40.vGap,
                      Text(
                        AppLocalizations.of(context)?.kVerificationCodeLabel ??
                            '',
                        style: TextStyle(
                            fontFamily: AppData.shared.fontFamily2,
                            fontWeight: FontWeight.w600,
                            fontSize: AppData.shared.getExtraFontSize()),
                      ),
                      kMarginMedium2.vGap,
                      Text(
                        AppLocalizations.of(context)?.kSendCodeToNumberLabel ??
                            '',
                        style: TextStyle(
                            fontSize: AppData.shared.getSmallFontSize()),
                      ),
                      kMarginMedium2.vGap,
                      _buildPinView(),
                      kMarginMedium2.vGap,
                      Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.kExpireIn ?? '',
                            style: TextStyle(
                                fontSize: AppData.shared.getSmallFontSize()),
                          ),
                          Text(
                            timerText,
                            style: TextStyle(
                                fontSize: AppData.shared.getSmallFontSize()),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              ///loading
              if (bloc.isLoading == true)
                LoadingView(
                    indicator: Indicator.ballBeat,
                    indicatorColor: kPrimaryColor)
            ],
          ),
        ),
        bottomNavigationBar: Consumer<AuthBloc>(
          builder: (context, bloc, child) => Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
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
                      bloc
                          .verifyOtp(pinController.text, token)
                          .then((response) {
                        PageNavigator(ctx: context).nextPage(
                            page: ChangePasswordPage(
                          isChangePassword: false,
                          token: response.token,
                        ));
                      }).catchError((error) {
                        showCommonDialog(
                            context: context,
                            dialogWidget: ErrorDialogView(
                                errorMessage: error.toString()));
                      });
                    },
                    context: context),
                Positioned(
                  top: -10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)?.kDidNotReceiveCode ?? '',
                        style: TextStyle(
                            fontSize: AppData.shared.getSmallFontSize()),
                      ),
                      TextButton(
                          onPressed: () {
                            if (_start == 300) {
                              bloc
                                  .onTapForgorPasswordSend(widget.phone ?? '')
                                  .then((response) {
                                token = response.data?.token ?? '';
                                startTimer();
                              });
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)?.kResend ?? '',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w700),
                          ))
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget _buildPinView() {
    final defaultPinTheme = PinTheme(
      width: kSize64,
      height: kMargin60,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      textStyle: const TextStyle(
        fontSize: kTextRegular22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: kInputBackgroundColor,
        borderRadius: BorderRadius.circular(kMarginMedium),
      ),
    );
    final submittedPinTheme = PinTheme(
      width: kSize64,
      height: kMargin60,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      textStyle: const TextStyle(
        fontSize: kTextRegular22,
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
