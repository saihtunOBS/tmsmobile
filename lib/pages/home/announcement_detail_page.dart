import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/announcement_detail_bloc.dart';
import 'package:tmsmobile/data/vos/announcement_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/cache_image.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import '../../data/app_data/app_data.dart';
import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';

class AnnouncementDetailPage extends StatelessWidget {
  const AnnouncementDetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AnnouncementDetailBloc(id),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, kMargin60),
            child: GradientAppBar(
              kCloseLabel,
            )),
        body: Consumer<AnnouncementDetailBloc>(
            builder: (context, bloc, child) => bloc.isLoading == true
                ? LoadingView(
                    indicator: Indicator.ballBeat,
                    indicatorColor: kPrimaryColor)
                : _buildBody(bloc.announcementDetail as AnnouncementVO)),
      ),
    );
  }

  Widget _buildBody(AnnouncementVO data) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kMarginMedium2, vertical: kMarginMedium2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: kSize180,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kMarginMedium),
                child: cacheImage(data.photos?.first ?? ''),
              ),
            ),
            5.vGap,
            Row(
              spacing: kMarginMedium,
              children: [
                Icon(CupertinoIcons.calendar),
                Text(
                  DateFormatter.formatDate(data.createdAt ?? DateTime.now()),
                  style: TextStyle(
                      fontSize: kTextSmall, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            kMarginMedium2.vGap,
            Text(
              data.title ?? '',
              style: TextStyle(
                  fontFamily: AppData.shared.fontFamily2,
                  fontSize: kTextRegular24,
                  fontWeight: FontWeight.w700),
            ),
            kMarginMedium2.vGap,
            Text(
              data.description ?? '',
              style: TextStyle(
                fontSize: kTextRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
