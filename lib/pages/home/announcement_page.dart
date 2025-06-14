import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/announcement_bloc.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/announcement_list_item.dart';
import 'package:tmsmobile/pages/home/announcement_detail_page.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/empty_view.dart';

import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../widgets/appbar.dart';
import '../../widgets/loading_view.dart';
import 'package:tmsmobile/l10n/app_localizations.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({super.key});

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnnouncementBloc>().updateToken();
      context.read<AnnouncementBloc>().getAnnouncement();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<AnnouncementBloc>(context);

    return Container(
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
            child: GradientAppBar(
                AppLocalizations.of(context)?.kAnnouncementLabel ?? '')),
        body: RefreshIndicator(
          backgroundColor: kBackgroundColor,
          elevation: 0.0,
          onRefresh: () async {
            HapticFeedback.mediumImpact();
            bloc.getAnnouncement();
          },
          child: bloc.isLoading == true
              ? LoadingView()
              : Stack(children: [
                  bloc.announcementList.isEmpty
                      ? Center(
                          child: EmptyView(
                              imagePath: kNoAnnouncementImage,
                              title: AppLocalizations.of(context)
                                      ?.kNoAnnouncementLabel ??
                                  '',
                              subTitle: AppLocalizations.of(context)
                                      ?.kThereisNoAnnouncementLabel ??
                                  ''),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: kMarginMedium2,
                              vertical: kMarginMedium2),
                          itemCount: bloc.announcementList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                        PageNavigator(ctx: context)
                                            .popUp(AnnouncementDetailPage(
                                      id: bloc.announcementList[index].id ?? '',
                                    ))),
                                child: AnnouncementListItem(
                                  data: bloc.announcementList[index],
                                ));
                          }),

                  ///loading
                  if (bloc.isLoading == true) LoadingView()
                ]),
        ),
      ),
    );
  }
}
