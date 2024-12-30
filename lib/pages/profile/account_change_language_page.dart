import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/language_bloc.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
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

    ///
    setUpLanguage();
    super.initState();
  }

  setUpLanguage() {
    if (PersistenceData.shared.getLocale() == null ||
        PersistenceData.shared.getLocale() == 'en') {
      _selectedValue = 0;
    } else {
      _selectedValue = 1;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => LanguageBloc(),
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
                    height: MediaQuery.of(context).size.height * 0.14,
                  ),
                  Consumer<LanguageBloc>(
                    builder: (context, bloc, child) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: kMargin24),
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Choose Language'.tr(),
                            style: GoogleFonts.crimsonPro(
                                fontWeight: FontWeight.w600,
                                fontSize: kTextRegular24),
                          ),
                          Column(
                            children: languages.asMap().entries.map((entry) {
                              return RadioListTile(
                                  value: entry.key,
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -2),
                                  groupValue: _selectedValue,
                                  title: entry.value,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedValue = value;
                                      switch (value) {
                                        case 0:
                                          PersistenceData.shared
                                              .saveLocale('en_US');
                                        case 1:
                                          PersistenceData.shared
                                              .saveLocale('my_MM');
                                          break;
                                        default:
                                      }
                                    });
                                    bloc.setLocale();
                                  });
                            }).toList(),
                          ),
                        ],
                      ),
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
