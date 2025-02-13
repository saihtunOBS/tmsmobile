import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/complaint_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import '../../data/app_data/app_data.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ComplainDetailPage extends StatelessWidget {
  ComplainDetailPage({super.key, this.isPending, this.complaintId});
  final bool? isPending;
  final String? complaintId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ComplaintBloc(complaintId: complaintId, isDetail: true),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kMargin60),
            child: GradientAppBar(
              AppLocalizations.of(context)?.kDetailLabel ?? '',
            )),
        body: Selector<ComplaintBloc, bool>(
          selector: (p0, p1) => p1.isLoading,
          builder: (context, isLoading, child) => isLoading
              ? LoadingView()
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // isPending == true ? 4.vGap : kMargin24.vGap,
                  // isPending == true ? SizedBox.shrink() : _buildHeader(context),
                  _buildBody()
                ]),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      child: Column(
        spacing: kMargin10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Row(
                  spacing: kMargin10,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          kLogoFrameImage,
                          width: kSize40,
                          height: kSize40,
                        ),
                        Image.asset(
                          kAppLogoImage,
                          width: kMargin30,
                          height: kMargin30,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Steve',
                          style: TextStyle(
                              fontSize: kTextRegular,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Customer Service',
                          style: TextStyle(
                            fontSize: kTextRegular,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _showAlertDialog(context),
                child: Container(
                  width: kSize70,
                  height: kSize34,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(kMargin6)),
                  child: Center(
                    child: Text(
                      kRatingLabel,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: kWhiteColor),
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<ComplaintBloc>(
      builder: (context, bloc, child) => Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kMarginMedium2, vertical: kMargin10),
        child: Column(
          spacing: kMargin5 - 1,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.vGap,
            Text(
              AppLocalizations.of(context)?.kCompliantLabel ?? '',
              style: TextStyle(
                  fontFamily: AppData.shared.fontFamily2,
                  fontWeight: FontWeight.w700,
                  fontSize: AppData.shared.getMediumFontSize()),
            ),
            Text(
              bloc.complaintDetail?.complaint ?? '',
              style: TextStyle(
                fontSize: kTextRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> ratings = [
    kSatisfiedLabel,
    kGoodLabel,
    kNeutralLabel,
    kBadlabel,
    kUnStatisfiedLabel
  ];

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: kSize300, // Set the custom width
            height: null, // Set the custom height
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        kHowWouldYouRateLabel,
                        style: TextStyle(
                            fontSize: kTextRegular, color: kWhiteColor),
                      ),
                      kMarginMedium2.vGap,
                      Column(
                        spacing: kMargin6,
                        children: ratings.asMap().entries.map((entry) {
                          return Container(
                            height: kSize40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius:
                                    BorderRadius.circular(kMarginMedium)),
                            child: Center(
                              child: Text(entry.value),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Positioned(
                      top: -kSize40,
                      right: -kSize40,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.cancel,
                            color: kWhiteColor,
                            size: kSize26,
                          )))
                ]),
          ),
        );
      },
    );
  }
}
