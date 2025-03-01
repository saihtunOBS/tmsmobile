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

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var notiBloc = context.read<NotificationBloc>();
      notiBloc.getNotification();
    });

    super.initState();
  }

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
            Future.delayed(Duration(seconds: 2), () {});
            bloc.getNotification();
          },
          child: bloc.isLoading == true ? LoadingView() : bloc.notiLists.isEmpty
              ? EmptyView(
                  imagePath: kNoNotiImage,
                  title:
                      AppLocalizations.of(context)?.kNoNotificationLabel ?? '',
                  subTitle: AppLocalizations.of(context)
                          ?.kThereisNoNotificationLabel ??
                      '')
              : Column(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: kDarkBlueColor,
                        )),
                        Text(
                          AppLocalizations.of(context)?.kNewNotificationLabel ??
                              '',
                          style: TextStyle(
                              fontSize: kTextRegular2x + 1,
                              fontWeight: FontWeight.bold,
                              color: kDarkBlueColor),
                        ),
                        Expanded(
                            child: Divider(
                          color: kDarkBlueColor,
                        ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: bloc.notiLists.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            left: kMarginMedium2,
                            right: kMarginMedium2,
                            top: kMarginMedium2,
                            bottom: 80),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (bloc.notiLists[index].referenceType ==
                                  'Announcement') {
                                Navigator.of(context).push(
                                    PageNavigator(ctx: context)
                                        .popUp(AnnouncementDetailPage(
                                  id: bloc.notiLists[index].referenceData?.id ??
                                      '',
                                )));
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
                ]),
        ),
      ),
    );
  }
}
