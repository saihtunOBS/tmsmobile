import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/announcement_detail_bloc.dart';
import 'package:tmsmobile/data/vos/announcement_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/widgets/cache_image.dart';
import 'package:tmsmobile/widgets/image_view.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import '../../data/app_data/app_data.dart';
import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import 'package:tmsmobile/l10n/app_localizations.dart';

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
              AppLocalizations.of(context)?.kCloseLabel ?? '',
            )),
        body: Consumer<AnnouncementDetailBloc>(
            builder: (context, bloc, child) => bloc.isLoading == true
                ? LoadingView()
                : _buildBody(
                    bloc.announcementDetail as AnnouncementVO, context)),
      ),
    );
  }

  Widget _buildBody(AnnouncementVO data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            13.vGap,
            data.photos?.isEmpty ?? true
                ? SizedBox()
                : GestureDetector(
                    onTap: () => showDialogImage(context, data.photos?.first),
                    child: SizedBox(
                      height: kSize180,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kMarginMedium),
                        child: cacheImage(data.photos?.first ?? ''),
                      ),
                    ),
                  ),
            5.vGap,
            data.photos?.isEmpty ?? true
                ? SizedBox.shrink()
                : Row(
                    spacing: kMarginMedium - 3,
                    children: [
                      Icon(CupertinoIcons.calendar),
                      Text(
                        DateFormatter.formatDate2(
                            data.createdAt ?? DateTime.now()),
                        style: TextStyle(
                            fontSize: kTextSmall, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
            data.photos?.isEmpty ?? true ? 0.vGap : kMarginMedium2.vGap,
            Text(
              data.title ?? '',
              style: TextStyle(
                  fontFamily: AppData.shared.fontFamily2,
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
            ),
            8.vGap,
            HtmlWidget(
              data.description ?? '',
              textStyle: TextStyle(fontSize: kTextRegular - 1),
            ),
            20.vGap
          ],
        ),
      ),
    );
  }
}
