import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/announcement_bloc.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/announcement_list_item.dart';
import 'package:tmsmobile/pages/home/announcement_detail_page.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/empty_view.dart';

import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../widgets/appbar.dart';
import '../../widgets/loading_view.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AnnouncementBloc(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: kBackgroundColor,
            image: DecorationImage(
                image: AssetImage(kBillingBackgroundImage), fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
              preferredSize: Size(double.infinity, kMargin60),
              child: GradientAppBar(kAnnouncementLabel)),
          body: Consumer<AnnouncementBloc>(
            builder: (context, bloc, child) => bloc.isLoading == true
                ? LoadingView(
                    indicator: Indicator.ballBeat,
                    indicatorColor: kPrimaryColor)
                : Stack(children: [
                    bloc.announcementList.isEmpty
                        ? Center(
                            child: EmptyView(
                                imagePath: kNoAnnouncementImage,
                                title: kNoAnnouncementLabel,
                                subTitle: kThereisNoAnnouncementLabel),
                          )
                        : RefreshIndicator(
                            onRefresh: () async => bloc.getAnnouncement(),
                            child: ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kMarginMedium2,
                                    vertical: kMarginMedium2),
                                itemCount: bloc.announcementList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () => Navigator.of(context).push(
                                              PageNavigator(ctx: context)
                                                  .popUp(AnnouncementDetailPage(
                                            id: bloc.announcementList[index]
                                                    .id ??
                                                '',
                                          ))),
                                      child: AnnouncementListItem(
                                        data: bloc.announcementList[index],
                                      ));
                                }),
                          ),

                    ///loading
                    if (bloc.isLoading == true)
                      LoadingView(
                          indicator: Indicator.ballBeat,
                          indicatorColor: kPrimaryColor)
                  ]),
          ),
        ),
      ),
    );
  }
}
