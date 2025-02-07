import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/change_profile_bloc.dart';
import 'package:tmsmobile/data/vos/user_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/date_formatter.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/widgets/loading_view.dart';

import '../../data/app_data/app_data.dart';
import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../utils/images.dart';
import '../../widgets/cache_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeProfilePage extends StatelessWidget {
  const ChangeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangeProfileBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Consumer<ChangeProfileBloc>(
          builder: (context, bloc, child) => Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            fit: StackFit.expand,
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  kBillingBackgroundImage,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(top: 0, child: ProfileAppbar()),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: kMargin60, left: kMargin80, right: kMargin80),
                    child: _buildHeader(context),
                  ),
                  18.vGap,
                  _buildListView(bloc.userData ?? UserVO(), context)
                ],
              ),

              ///loading
              if (bloc.isLoading == true) LoadingView()
            ],
          ),
        ),
      ),
    );
  }

  _showCupertinoActionSheet(BuildContext context, ChangeProfileBloc bloc) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(
            AppLocalizations.of(context)?.kChooseOptionLabel ?? '',
            style: TextStyle(
                fontSize: AppData.shared.getMediumFontSize(),
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          message: Text(
            AppLocalizations.of(context)?.kSelectOneOptionLabel ?? '',
            style: TextStyle(color: Colors.black),
          ),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () {
                bloc.selectImage(0);
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context)?.kCameraLabel ?? '',
                style: TextStyle(
                    fontSize: kTextRegular2x, fontWeight: FontWeight.w500),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                bloc.selectImage(1);
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)?.kGalleryLabel ?? '',
                  style: TextStyle(
                      fontSize: kTextRegular2x, fontWeight: FontWeight.w500)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Consumer<ChangeProfileBloc>(
      builder: (context, bloc, child) => SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          InkWell(
            onTap: () => showDialogImage(context,
                bloc.imgFile == null ? bloc.userData?.photo : bloc.imgFile!),
            child: Container(
              height: kSize100,
              width: kSize100,
              padding: EdgeInsets.all(kMargin5 - 1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kThirdColor],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Container(
                height: kSize100,
                decoration:
                    BoxDecoration(color: kWhiteColor, shape: BoxShape.circle),
                width: kSize100,
                child: ClipOval(
                    child: bloc.imgFile != null
                        ? Image.file(
                            bloc.imgFile!,
                            fit: BoxFit.cover,
                          )
                        : cacheImage(bloc.userData?.photo ?? '')),
              ),
            ),
          ),
          10.vGap,
          InkWell(
            onTap: () => _showCupertinoActionSheet(context, bloc),
            child: Container(
              height: kSize28,
              width: kSize110,
              padding: EdgeInsets.symmetric(horizontal: kMargin10),
              decoration: BoxDecoration(
                  color: kPrimaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(kMarginMedium2)),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)?.kChangeProfileLabel ?? '',
                  style: TextStyle(
                      fontSize: kTextRegular13,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void showDialogImage(BuildContext context, dynamic imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageUrl is File
                    ? InteractiveViewer(
                        maxScale: 5.0,
                        minScale: 0.01,
                        child: Image.file(imageUrl))
                    : InteractiveViewer(
                        maxScale: 5.0,
                        minScale: 0.01,
                        child: cacheImage(imageUrl)),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: kRedColor,
                      )))
            ],
          ),
        );
      },
    );
  }

  Widget _buildListView(UserVO userData, BuildContext context) {
    return Column(spacing: kMargin12, children: [
      _buildListDetail(
          title: AppLocalizations.of(context)?.kCreatedDateLabel ?? '',
          value:
              DateFormatter.formatDate(userData.createdDate ?? DateTime.now())),
      _buildListDetail(
          title: AppLocalizations.of(context)?.kNameLabel ?? '',
          value: userData.tenantName ?? ''),
      _buildListDetail(
          title: AppLocalizations.of(context)?.kEmailAddressLabel ?? '',
          value: userData.email ?? ''),
      _buildListDetail(
          title: AppLocalizations.of(context)?.kPhoneNumberLabel ?? '',
          value: userData.phoneNumber ?? ''),
      _buildListDetail(
          title: AppLocalizations.of(context)?.kCityLabel ?? '',
          value: userData.city?.cityName ?? ''),
      _buildListDetail(
          title: AppLocalizations.of(context)?.kTownshipLabel ?? '',
          value: userData.township?.townshipName ?? ''),
      _buildListDetail(
          title: AppLocalizations.of(context)?.kAddressLabel ?? '',
          value: userData.address ?? ''),
      _buildListDetail(
          title: AppLocalizations.of(context)?.kNoOfPropertyLabel ?? '',
          value: '${userData.numberOfShops ?? 0}'),
    ]);
  }

  Widget _buildListDetail({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: AppData.shared.getSmallFontSize()),
          ),
          kSize40.hGap,
          Expanded(
            child: Text(
              value,
              softWrap: true,
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: kTextRegular + 1, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
