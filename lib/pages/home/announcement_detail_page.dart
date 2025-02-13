import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../../utils/html_text.dart';
import '../../widgets/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                : _buildBody(bloc.announcementDetail as AnnouncementVO,context)),
      ),
    );
  }

  Widget _buildBody(AnnouncementVO data,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kMarginMedium2, vertical: kMarginMedium2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  fontSize: AppData.shared.getExtraFontSize(),
                  fontWeight: FontWeight.w700),
            ),
            kMarginMedium2.vGap,
            Text(
              htmlParser(data.description ?? ''),
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
