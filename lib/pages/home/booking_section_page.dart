import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/list_items/section_list_item.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/images.dart';

import '../../bloc/booking_section_bloc.dart';
import '../../data/app_data/app_data.dart';
import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import '../../widgets/cache_image.dart';
import '../../widgets/gradient_button.dart';
import 'package:tmsmobile/l10n/app_localizations.dart';

class BookingSectionPage extends StatefulWidget {
  const BookingSectionPage({super.key});

  @override
  State<BookingSectionPage> createState() => _BookingSectionPageState();
}

class _BookingSectionPageState extends State<BookingSectionPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingSectionBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kMargin60),
            child: GradientAppBar(
              AppLocalizations.of(context)?.kBackLabel ?? '',
            )),
        body: Consumer<BookingSectionBloc>(builder: (context, bloc, child) {
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                10.vGap,
                _buildHeader(),
                26.vGap,
                _buildDescription(),
                17.vGap,
                AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    child: SizedBox(
                        height: bloc.isOpenDate == true ? null : 0,
                        child: _buildCalendarPickerView(context))),
                AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    child: SizedBox(
                        height: bloc.isSectionView == true ? null : 0,
                        child: _buildSelectSectionView())),
                AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    child: SizedBox(
                        height: bloc.isReserveView == true ? null : 0,
                        child: _buildReserveView())),
                20.vGap,
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: kMarginMedium2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 5,
              color: kGreyColor,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 163,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: cacheImage(
                  'https://d3h1lg3ksw6i6b.cloudfront.net/media/image/2024/12/04/f8df0173d8414f47ad9b7b34021d1a29_8-bangkok-top-rooftop-bars-for-stunning-views-and-cool-breezes_%287%29.jpg'),
            ),
          ),
          6.vGap,
          Text(
            'Rooftop',
            style: TextStyle(
                fontFamily: AppData.shared.fontFamily2,
                fontSize: kTextRegular22 - 2,
                fontWeight: FontWeight.bold),
          ),
          5.vGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '100000 Ks',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                '1 Section',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: kMarginMedium2),
        width: double.infinity,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: Text(
                AppLocalizations.of(context)?.kDescriptionLabel ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kTextRegular + 3,
                    color: Colors.black),
              ),
              hintText: 'Only 5 persons',
              hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: kTextSmall,
                  fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(width: 1, color: kBlackColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(width: 1, color: kBlackColor)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              )),
        ));
  }

  Widget _buildCalendarPickerView(BuildContext context) {
    return Consumer<BookingSectionBloc>(builder: (context, bloc, child) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: kMarginMedium2),
        child: Column(
          children: [
            SizedBox(
              height: 89,
              width: double.infinity,
              child: Image.asset(
                kBookingStatusImage,
                fit: BoxFit.cover,
              ),
            ),
            _buildCalendarPicker(context),
          ],
        ),
      );
    });
  }

  Widget _buildCalendarPicker(BuildContext context) {
    final config = CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        disableModePicker: true,
        daySplashColor: kGreyColor,
        controlsTextStyle:
            TextStyle(fontSize: kTextRegular18, fontWeight: FontWeight.bold),
        selectedDayHighlightColor: kRedColor,
        monthTextStyle: TextStyle(fontSize: kTextRegular2x),
        selectableDayPredicate: (day) => true,
        selectedDayTextStyle:
            TextStyle(fontSize: kTextRegular2x, color: kWhiteColor),
        weekdayLabelTextStyle: TextStyle(fontSize: kTextRegular2x),
        dayTextStyle: TextStyle(fontSize: kTextRegular2x));
    return Consumer<BookingSectionBloc>(
      builder: (context, bloc, child) => Column(
        children: [
          Localizations.override(
            context: context,
            locale: Locale('en'),
            child: CalendarDatePicker2(
              config: config,
              value: bloc.selectedDate,
              onValueChanged: (value) {
                bloc.onChangeDate(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<String> fromTimes = ['9:00 AM', '12:00 PM', '3:00 PM'];
  List<String> toTimes = ['12:00 PM', '3:00 PM', '6:00 PM'];

  Widget _buildSelectSectionView() {
    return Consumer<BookingSectionBloc>(
      builder: (context, bloc, child) =>
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: kMarginMedium2),
          child: Text(
            DateFormatter.formatDate2(
                bloc.selectedDate.first ?? DateTime.now()),
            style: TextStyle(
                fontSize: kTextRegular2x, fontWeight: FontWeight.bold),
          ),
        ),
        4.vGap,
        Padding(
          padding: const EdgeInsets.only(left: kMarginMedium2),
          child: Text(
            AppLocalizations.of(context)?.kClickToSelectLabel ?? '',
            style: TextStyle(
                fontSize: kTextRegular13 + 1, fontWeight: FontWeight.w700),
          ),
        ),
        4.vGap,
        ListView.builder(
            itemCount: fromTimes.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  bloc.onSelectSection(fromTimes[index], toTimes[index]);
                },
                child: SectionListItem(
                    fromTime: fromTimes[index], toTime: toTimes[index]),
              );
            }),
      ]),
    );
  }

  Widget _buildReserveView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.vGap,
        _addMoreSectionView(),
        10.vGap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
          child: Text(
            AppLocalizations.of(context)?.kNoFoGuestLabel ?? '',
            style: TextStyle(
                fontSize: kTextRegular2x - 2, fontWeight: FontWeight.w700),
          ),
        ),
        3.vGap,
        Container(
          height: 48,
          margin: EdgeInsets.symmetric(horizontal: kMarginMedium2),
          padding: EdgeInsets.symmetric(horizontal: kMargin10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: kGreyColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(kMarginMedium)),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppLocalizations.of(context)?.kNoFoGuestLabel ?? '',
                hintStyle: TextStyle(fontSize: kTextRegular2x - 2)),
          ),
        ),
        24.vGap,
        gradientButton(
            onPress: () {},
            context: context,
            title: AppLocalizations.of(context)?.kReserveLabel ?? ''),
        24.vGap,
        Center(
          child: Text(
            AppLocalizations.of(context)?.kYouWontBeChargeYetLabel ?? '',
            style: TextStyle(
                fontSize: kTextRegular2x, fontWeight: FontWeight.bold),
          ),
        ),
        24.vGap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '80000 Ks / 1section x 1',
                style: TextStyle(
                    fontSize: kTextRegular13 + 1, fontWeight: FontWeight.w700),
              ),
              Text('64000 ks',
                  style: TextStyle(
                      fontSize: kTextRegular13 + 1,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)?.kTotalLabel ?? '',
                  style: TextStyle(
                      fontSize: kTextRegular2x, fontWeight: FontWeight.bold)),
              Text('64000 ks',
                  style: TextStyle(
                      fontSize: kTextRegular2x, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _addMoreSectionView() {
    return Consumer<BookingSectionBloc>(builder: (context, bloc, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormatter.formatDate2(
                      bloc.selectedDate.first ?? DateTime.now()),
                  style: TextStyle(
                      fontSize: kTextRegular2x, fontWeight: FontWeight.bold),
                ),
                IgnorePointer(
                  ignoring: sheetToTimeArray.isEmpty,
                  child: InkWell(
                    onTap: () => showModalBottomSheet(
                        context: context,
                        backgroundColor: kWhiteColor,
                        builder: (_) {
                          return _sectionModalSheet(bloc);
                        }),
                    child: Container(
                      width: 55,
                      height: 24,
                      decoration: BoxDecoration(
                          color: sheetFromTimeArray.isEmpty
                              ? kPrimaryColor.withValues(alpha: 0.5)
                              : kPrimaryColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          '+ Add',
                          style: TextStyle(
                              color: kWhiteColor, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          2.vGap,
          ListView.builder(
              itemCount: sectionFromTimeArray.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SectionListItem(
                    fromTime: sectionFromTimeArray[index],
                    toTime: sectionToTimeArray[index]);
              })
        ],
      );
    });
  }

  Widget _sectionModalSheet(BookingSectionBloc bloc) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          25.vGap,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kMarginMedium2,
            ),
            child: Text(
              AppLocalizations.of(context)?.kClickToSelectLabel ?? '',
              style: TextStyle(
                  fontSize: kTextRegular2x - 2, fontWeight: FontWeight.w700),
            ),
          ),
          5.vGap,
          ListView.builder(
              itemCount: sheetFromTimeArray.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    bloc.onSelectSection(
                        sheetFromTimeArray[index], sheetToTimeArray[index]);
                    Navigator.pop(context);
                  },
                  child: SectionListItem(
                      fromTime: sheetFromTimeArray[index],
                      toTime: sheetToTimeArray[index]),
                );
              })
        ],
      ),
    );
  }
}
