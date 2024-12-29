import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/change_password_bloc.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';

class AccountChangeLanguagePage extends StatefulWidget {
  const AccountChangeLanguagePage({super.key});

  @override
  State<AccountChangeLanguagePage> createState() =>
      _AccountChangeLanguagePageState();
}

class _AccountChangeLanguagePageState extends State<AccountChangeLanguagePage> {
  List<Widget> languages = [];
  int? _selectedValue;
  @override
  void initState() {
    languages = [
      _buildLanguageRow(title: kEnglishlabel, image: kEngIcon),
      _buildLanguageRow(title: kMyanmarLabel, image: kMMIcon)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => ChangePasswordBloc(),
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  kBillingBackgroundImage,
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: kMarginMedium2,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.16,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kMargin24),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kChooseLanguageLabel,
                          style: GoogleFonts.crimsonPro(
                              fontWeight: FontWeight.w600,
                              fontSize: kTextRegular24),
                        ),
                        Column(
                          children: languages.asMap().entries.map((entry) {
                            return RadioListTile(
                                value: entry.key,
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -2),
                                groupValue: _selectedValue,
                                title: entry.value,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue = value;
                                  });
                                });
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              ///appbar
              Positioned(top: 0, child: ProfileAppbar()),
            ],
          ),
        ));
  }

  Widget _buildLanguageRow({required String title, required String image}) {
    return Row(
      spacing: kMargin12,
      children: [
        Image.asset(
          image,
          width: kSize28,
          height: kSize28,
        ),
        Text(
          title,
          style:
              TextStyle(fontSize: kTextRegular18, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
