import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/booking_hour_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/widgets/gradient_button.dart';

import '../../data/app_data/app_data.dart';
import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import '../../widgets/cache_image.dart';
import 'package:tmsmobile/l10n/app_localizations.dart';

class BookingHourPage extends StatefulWidget {
  const BookingHourPage({super.key});

  @override
  State<BookingHourPage> createState() => _BookingHourPageState();
}

class _BookingHourPageState extends State<BookingHourPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingHourBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kMargin60),
            child: GradientAppBar(
              AppLocalizations.of(context)?.kBackLabel ?? '',
            )),
        body: Consumer<BookingHourBloc>(builder: (context, bloc, child) {
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                10.vGap,
                _buildHeader(),
                14.vGap,
                _buildSelectDateSection(),
                8.vGap,
                bloc.isLoading == true
                    ? SizedBox()
                    : AnimatedSize(
                        duration: Duration(milliseconds: 300),
                        child: SizedBox(
                            height: bloc.isOpenDate == true ? null : 0,
                            child: _buildCalendarPickerView(context))),
                _buildTimePickerView(),
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
          Text(
            '100000 Ks / 1hr',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectDateSection() {
    return Consumer<BookingHourBloc>(
      builder: (context, bloc, child) => Container(
        height: 53,
        margin: EdgeInsets.symmetric(horizontal: kMarginMedium2),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: kBlackColor)),
        child: Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                bloc.onSelectDate();
                bloc.onSelectFromOrToDate(true);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        AppLocalizations.of(context)?.kFromLabel ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: kTextSmall - 1),
                      ),
                    ),
                    6.vGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              size: 16,
                            ),
                            3.hGap,
                            Text(
                              bloc.fromDate == ''
                                  ? AppLocalizations.of(context)
                                          ?.kSelectDateTimeLabel ??
                                      ''
                                  : bloc.fromDate,
                              style: TextStyle(
                                  color: kBlackColor,
                                  fontWeight: bloc.fromDate == ''
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                  fontSize: kTextSmall),
                            ),
                          ],
                        ),
                        Text(
                          '${bloc.fromTime}  ',
                          style: TextStyle(
                              color: kBlackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: kTextSmall),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
            Container(
              height: 53,
              width: 1,
              color: kBlackColor,
            ),
            Expanded(
                child: InkWell(
              onTap: () {
                if (bloc.fromDate == '') return;
                bloc.onSelectDate();
                bloc.onSelectFromOrToDate(false);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        AppLocalizations.of(context)?.kToLabel ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: kTextSmall - 1),
                      ),
                    ),
                    6.vGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              size: 16,
                            ),
                            3.hGap,
                            Text(
                              bloc.toDate == ''
                                  ? AppLocalizations.of(context)
                                          ?.kSelectDateTimeLabel ??
                                      ''
                                  : bloc.toDate,
                              style: TextStyle(
                                  color: kBlackColor,
                                  fontWeight: bloc.toDate == ''
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                  fontSize: kTextSmall),
                            ),
                          ],
                        ),
                        Text(
                          '${bloc.toTime}  ',
                          style: TextStyle(
                              color: kBlackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: kTextSmall),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePickerView() {
    return Consumer<BookingHourBloc>(
      builder: (context, bloc, child) => Container(
        margin: EdgeInsets.symmetric(horizontal: kMarginMedium2),
        child: AnimatedSize(
          duration: Duration(milliseconds: 300),
          child: SizedBox(
            height: bloc.isTimeView == true ? null : 0,
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
                10.vGap,
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: kGreyColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(kMarginMedium)),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)?.kSelectTimeLabel ?? '',
                      style: TextStyle(
                          fontSize: kTextRegular18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                5.vGap,
                SizedBox(
                  height: 200,
                  child: Localizations.override(
                    context: context,
                    locale: Locale('en'),
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.now(),
                      minimumDate: bloc.isSelectFromDate == true
                          ? null
                          : DateFormatter.stringToDate(bloc.fromDate),
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: false, // Change to true for 24-hour format
                      onDateTimeChanged: (DateTime newDateTime) {
                        bloc.onChangeTime(TimeOfDay(
                            hour: newDateTime.hour,
                            minute: newDateTime.minute));
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        bloc.onClickCancelCaneldar();
                      },
                      child: SizedBox(
                        height: 31,
                        width: 68,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)?.kCancelLabel ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    10.hGap,
                    GestureDetector(
                      onTap: () {
                        bloc.onClickSelectTimeOk();
                      },
                      child: Container(
                        height: 31,
                        width: 68,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: kDarkBlueColor),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)?.kOkLabel ?? '',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarPickerView(BuildContext context) {
    return Consumer<BookingHourBloc>(
      builder: (context, bloc, child) => Container(
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
            _buildCalendarWithActionButtons(context, bloc),
            20.vGap,
            _buildOccupiAndMaintenanceView(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarWithActionButtons(
      BuildContext context, BookingHourBloc bloc) {
    final config = CalendarDatePicker2WithActionButtonsConfig(
        lastDate: DateTime.now(),
        calendarType: bloc.isSelectFromDate == true
            ? CalendarDatePicker2Type.single
            : CalendarDatePicker2Type.range,
        disableModePicker: true,
        rangeBidirectional: true,
        daySplashColor: kSecondGreyColor,
        controlsTextStyle:
            TextStyle(fontSize: kTextRegular18, fontWeight: FontWeight.bold),
        selectedDayHighlightColor: kRedColor,
        selectedRangeHighlightColor: Colors.greenAccent,
        selectedRangeDecorationPredicate: (
                {required dayToBuild,
                required decoration,
                required isEndDate,
                required isStartDate}) =>
            decoration.copyWith(color: Colors.greenAccent),
        monthTextStyle: TextStyle(fontSize: kTextRegular2x),
        selectedDayTextStyle:
            TextStyle(fontSize: kTextRegular2x, color: kWhiteColor),
        weekdayLabelTextStyle: TextStyle(fontSize: kTextRegular2x),
        dayTextStyle: TextStyle(fontSize: kTextRegular2x));
    return Consumer<BookingHourBloc>(
      builder: (context, bloc, child) => Column(
        children: [
          Stack(
            children: [
              Localizations.override(
                context: context,
                locale: Locale('en'),
                child: CalendarDatePicker2(
                  config: config,
                  value: bloc.isSelectFromDate == true
                      ? bloc.selectedDate
                      : [
                          bloc.rangeSelectDate,
                          DateTime.now(),
                        ],
                  onValueChanged: (value) {
                    bloc.onChangeDate(value);

                    if (bloc.isSelectFromDate == true) return;
                    if (bloc.fromDate.isNotEmpty) {
                      if (value.first.day <
                          DateFormatter.stringToDate(bloc.fromDate).day) {
                        bloc.rangeSelectDate =
                            DateFormatter.stringToDate(bloc.fromDate);
                        bloc.onSelectDate();
                      }
                    }
                  },
                ),
              ),
              Positioned(
                right: 0,
                bottom: -10,
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          bloc.onClickCancelCaneldar();
                        },
                        child: SizedBox(
                          height: 31,
                          width: 68,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)?.kCancelLabel ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      10.hGap,
                      GestureDetector(
                        onTap: () {
                          bloc.onClickOkCalendar();
                        },
                        child: Container(
                          height: 31,
                          width: 68,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: kDarkBlueColor),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)?.kOkLabel ?? '',
                              style: TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOccupiAndMaintenanceView() {
    return Container(
      padding: EdgeInsets.all(kMargin12 + 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSize18 - 2),
          color: kThirdColor.withValues(alpha: 0.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Occupied',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              5.vGap,
              Text(
                '9:00 AM - 12:00 PM',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Container(
            height: kMarginMedium,
            width: kMarginMedium,
            decoration: BoxDecoration(color: kRedColor, shape: BoxShape.circle),
          )
        ],
      ),
    );
  }

  Widget _buildReserveView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                '80000 Ks / 1hr x 8hr',
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
}
