import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/notification_bloc.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/noti_list_item.dart';
import 'package:tmsmobile/pages/home/announcement_detail_page.dart';
import 'package:tmsmobile/pages/home/complain_detail_page.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/appbar_header.dart';
import 'package:tmsmobile/widgets/empty_view.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<NotificationBloc>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: kBackgroundColor,
          image: DecorationImage(
              image: AssetImage(kBillingBackgroundImage), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          foregroundColor: kWhiteColor,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: AppbarHeader(),
          flexibleSpace: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimaryColor, kThirdColor],
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            HapticFeedback.mediumImpact();
            bloc.getNotification();
          },
          child: bloc.isLoading == true
              ? LoadingView()
              : bloc.notiLists.isEmpty
                  ? EmptyView(
                      imagePath: kNoNotiImage,
                      title:
                          AppLocalizations.of(context)?.kNoNotificationLabel ??
                              '',
                      subTitle: AppLocalizations.of(context)
                              ?.kThereisNoNotificationLabel ??
                          '')
                  : ListView.builder(
                      itemCount: bloc.notiLists.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          vertical: kMarginMedium2, horizontal: kMarginMedium2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (bloc.notiLists[index].referenceType ==
                                'Announcement') {
                              PageNavigator(ctx: context).nextPage(
                                  page: AnnouncementDetailPage(
                                      id: bloc.notiLists[index]
                                              .referenceData?.id ??
                                          ''));
                            } else {
                              PageNavigator(ctx: context).nextPage(
                                  page: ComplainDetailPage(
                                      complaintId: bloc.notiLists[index]
                                              .referenceData?.id ??
                                          ''));
                            }
                          },
                          child: NotiListItem(
                            data: bloc.notiLists[index],
                          ),
                        );
                      }),
        ),
      ),
    );
  }

  // Widget _buildNewNotiBody(BuildContext context) {
  //   return Column(
  //     children: [
  //       kMarginMedium2.vGap,
  //       Text(
  //         AppLocalizations.of(context)?.kNewNotificationLabel ?? '',
  //         style: TextStyle(
  //             fontSize: kTextRegular,
  //             color: kPrimaryColor,
  //             fontWeight: FontWeight.bold),
  //       ),
  //       10.vGap,
  //       ListView.builder(
  //           itemCount: 1,
  //           shrinkWrap: true,
  //           physics: NeverScrollableScrollPhysics(),
  //           padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
  //           itemBuilder: (context, index) {
  //             return GestureDetector(
  //               // onTap: () => PageNavigator(ctx: context)
  //               //     .nextPage(page: InvoiceDetailPage(billingData: BillingVO(),)),
  //               child: Padding(
  //                 padding: EdgeInsets.only(bottom: kMargin10),
  //                 child: NotiListItem(),
  //               ),
  //             );
  //           }),
  //       5.vGap,
  //       Container(
  //         height: 1,
  //         width: double.infinity,
  //         color: kGreyColor,
  //         margin: EdgeInsets.symmetric(horizontal: kMargin24),
  //       ),
  //       5.vGap,
  //     ],
  //   );
  // }
}
