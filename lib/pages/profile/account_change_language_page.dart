import 'package:flutter/material.dart';
import 'package:tmsmobile/bloc/language_bloc.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/l10n/app_localizations.dart';

import '../../data/app_data/app_data.dart';

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

    _setUpLanguage();
    super.initState();
  }

  _setUpLanguage() {
    if (PersistenceData.shared.getLocale() == 'my') {
      _selectedValue = 1;
    } else {
      _selectedValue = 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: 120,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kMargin24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 33,
                      child: Text(
                        AppLocalizations.of(context)?.choose_language ?? '',
                        style: TextStyle(
                            height: PersistenceData.shared.getLocale() == 'my'
                                ? 1
                                : 1,
                            fontFamily:
                                PersistenceData.shared.getLocale() == 'my'
                                    ? AppData.shared.fontFamily3
                                    : AppData.shared.fontFamily2,
                            fontWeight: FontWeight.w600,
                            fontSize: kTextRegular24),
                      ),
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
                                switch (value) {
                                  case 0:
                                    PersistenceData.shared.saveLocale('en');
                                    languageStreamController.sink.add('en');
                                  case 1:
                                    PersistenceData.shared.saveLocale('my');
                                    languageStreamController.sink.add('my');
                                    break;
                                  default:
                                }
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
    );
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
          style: TextStyle(
              fontSize: AppData.shared.getRegularFontSize(),
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
