// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/auth_bloc.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/common_dialog.dart';
import 'package:tmsmobile/widgets/error_dialog_view.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import '../../data/app_data/app_data.dart';
import '../../extension/route_navigator.dart';
import '../../utils/images.dart';
import '../../widgets/appbar_back_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'otp_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _phoneController = TextEditingController();
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthBloc(),
      child: Material(
        child: InkWell(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            extendBody: true,
            backgroundColor: kBackgroundColor,
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
            body: Selector<AuthBloc, bool?>(
              selector: (p0, p1) => p1.isLoading,
              builder: (context, loading, child) => Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kMargin24),
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
                          Text(
                            AppLocalizations.of(context)
                                    ?.kForgotPasswordLabel ??
                                '',
                            style: TextStyle(
                                fontFamily: AppData.shared.fontFamily2,
                                fontWeight: FontWeight.w600,
                                fontSize: AppData.shared.getExtraFontSize()),
                          ),
                          Text(
                            AppLocalizations.of(context)?.kSendOTPTextLabel ??
                                '',
                            style: TextStyle(
                                fontSize: AppData.shared.getSmallFontSize()),
                          ),
                          _buildTextField(
                              title: AppLocalizations.of(context)
                                      ?.kPhoneNumberLabel ??
                                  '',
                              icon: Icon(CupertinoIcons.phone),
                              controller: _phoneController,
                              isNumber: true),
                        ],
                      ),
                    ),
                  ),

                  ///loading
                  if (loading == true)
                    LoadingView(
                        indicator: Indicator.ballBeat,
                        indicatorColor: kPrimaryColor)
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
                    title: AppLocalizations.of(context)?.kSendLabel,
                    onPress: () {
                      bloc
                          .onTapForgorPasswordSend(_phoneController.text.trim())
                          .then((response) {
                        PageNavigator(ctx: context).nextPage(
                            page: OTPPage(
                          phone: _phoneController.text.trim(),token: response.data?.token,
                        ));
                      }).catchError((e) {
                        showCommonDialog(
                            context: context,
                            dialogWidget:
                                ErrorDialogView(errorMessage: e.toString()));
                      });
                    },
                    context: context),
              ]),
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
      bool? isNumber}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.nunito(
              fontSize: AppData.shared.getSmallFontSize(),
              fontWeight: FontWeight.w600),
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
                      keyboardType: isNumber == true
                          ? TextInputType.phone
                          : TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: title,
                          hintStyle: TextStyle(
                              fontSize: AppData.shared.getSmallFontSize())))),
              const SizedBox(
                width: kMargin5,
              ),

              ///icon
              icon
            ],
          ),
        ),
      ],
    );
  }
}
