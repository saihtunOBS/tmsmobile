// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/maintenance_bloc.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/room_shop_vo.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/common_dialog.dart';
import 'package:tmsmobile/widgets/error_dialog_view.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import '../../data/app_data/app_data.dart';

import '../../widgets/appbar.dart';
import '../../widgets/gradient_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaintenanceAndFillOutRequestPage extends StatefulWidget {
  const MaintenanceAndFillOutRequestPage({super.key, this.isMaintanence});
  final bool? isMaintanence;

  @override
  State<MaintenanceAndFillOutRequestPage> createState() =>
      _MaintenanceAndFillOutRequestPageState();
}

class _MaintenanceAndFillOutRequestPageState
    extends State<MaintenanceAndFillOutRequestPage> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    _nameController.text = PersistenceData.shared.getUser()?.tenantName ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MaintenanceBloc(context: context),
      child: Material(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: PreferredSize(
                preferredSize: Size(double.infinity, kMargin60),
                child: GradientAppBar(
                  widget.isMaintanence == true
                      ? AppLocalizations.of(context)
                              ?.kMaintenanceRequestLabel ??
                          ''
                      : AppLocalizations.of(context)?.kFillOutRequestLabel ??
                          '',
                )),
            body: SafeArea(
              child: Selector<MaintenanceBloc, bool?>(
                selector: (p0, p1) => p1.isLoading,
                builder: (context, loading, child) => Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kMarginMedium2,
                            vertical: kMarginMedium2),
                        child: Column(
                          spacing: kMargin10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextField(
                                maxLine: 1,
                                controller: _nameController,
                                isReadOnly: true,
                                title: AppLocalizations.of(context)
                                        ?.kTenantNameLabel ??
                                    '',
                                hint: 'Name'),
                            _buildRoomShopNameDropDown(),
                            widget.isMaintanence == true
                                ? _buildTypeIssueDropDown()
                                : SizedBox.shrink(),
                            _buildTextField(
                                maxLine: 5,
                                title: AppLocalizations.of(context)
                                        ?.kDescriptionLabel ??
                                    '',
                                hint: AppLocalizations.of(context)
                                        ?.kWriteDescriptionHereLabel ??
                                    ''),
                            _buildUploadImage(),
                            1.vGap
                          ],
                        ),
                      ),
                    ),

                    ///loading
                    if (loading == true)
                      LoadingView(
                          )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Consumer<MaintenanceBloc>(
              builder: (context, bloc, child) => Container(
                  color: kWhiteColor,
                  height: kBottomBarHeight,
                  child: Center(
                    child: gradientButton(
                        title: AppLocalizations.of(context)?.kSendRequestLabel,
                        onPress: () {
                          widget.isMaintanence == true
                              ? bloc.checkMaintenanceValidation()
                              : bloc.checkFillOutValidation();
                          bloc.validationMessage == 'success'
                              ? widget.isMaintanence == true
                                  ? bloc.onTapSendRequestMaintenance()
                                  : bloc.onTapSendRequestFillOut()
                              : showCommonDialog(
                                  context: context,
                                  dialogWidget: ErrorDialogView(
                                      errorMessage:
                                          bloc.validationMessage ?? ''));
                        },
                        context: context),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required int maxLine,
      TextEditingController? controller,
      bool? isReadOnly,
      required String title,
      required String hint}) {
    return Consumer<MaintenanceBloc>(
      builder: (context, bloc, child) => Column(
        spacing: kMargin5 - 1,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 3,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: AppData.shared.getSmallFontSize(),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '*',
                style: TextStyle(color: Colors.red, fontSize: kTextRegular3x),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kMargin10),
            decoration: BoxDecoration(
                color: kInputBackgroundColor,
                borderRadius: BorderRadius.circular(kMarginMedium)),
            child: TextField(
              maxLines: maxLine,
              controller: controller,
              onChanged: (value) {
                bloc.onChangeDescription(value);
              },
              readOnly: isReadOnly ?? false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle:
                      TextStyle(fontSize: AppData.shared.getSmallFontSize())),
            ),
          )
        ],
      ),
    );
  }

  /// shopname
  Widget _buildRoomShopNameDropDown() {
    return Consumer<MaintenanceBloc>(
      builder: (context, bloc, child) => Column(
        spacing: kMargin5 - 1,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 3,
            children: [
              Text(
                AppLocalizations.of(context)?.kRoomShopNameLabel ?? '',
                style: TextStyle(
                    fontSize: AppData.shared.getSmallFontSize(),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '*',
                style: TextStyle(color: Colors.red, fontSize: kTextRegular3x),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: kInputBackgroundColor,
                borderRadius: BorderRadius.circular(kMarginMedium)),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                  value: bloc.selectedRoomShopName,
                  isExpanded: true,
                  underline: Container(),
                  hint: Text(
                    AppLocalizations.of(context)?.kSelectRoomShopLabel ?? '',
                    style:
                        TextStyle(fontSize: AppData.shared.getSmallFontSize()),
                  ),
                  items: bloc.roomShops.map((value) {
                    return DropdownMenuItem(
                        value: value, child: Text(value.shop?.name ?? ''));
                  }).toList(),
                  onChanged: ((value) {
                    bloc.onChangeRoomShopName(value ?? RoomShopVO());
                  })),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTypeIssueDropDown() {
    return Consumer<MaintenanceBloc>(
      builder: (context, bloc, child) => Column(
        spacing: kMargin5 - 1,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 3,
            children: [
              Text(
                AppLocalizations.of(context)?.kTypeOfIssueLabel ?? '',
                style: TextStyle(
                    fontSize: AppData.shared.getSmallFontSize(),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '*',
                style: TextStyle(color: Colors.red, fontSize: kTextRegular3x),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: kInputBackgroundColor,
                borderRadius: BorderRadius.circular(kMarginMedium)),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                  value: bloc.selectedIssue,
                  isExpanded: true,
                  underline: Container(),
                  hint: Text(
                    AppLocalizations.of(context)?.kSelectTypeIssueLabel ?? '',
                    style:
                        TextStyle(fontSize: AppData.shared.getSmallFontSize()),
                  ),
                  items: bloc.typeOfIssues.asMap().entries.map((entry) {
                    return DropdownMenuItem(
                        value: entry.value.id,
                        child: Text(entry.value.name ?? ''));
                  }).toList(),
                  onChanged: ((value) {
                    bloc.onChangeIssue(value ?? '');
                  })),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUploadImage() {
    return Stack(
      children: [
        Consumer<MaintenanceBloc>(
          builder: (context, bloc, child) => GestureDetector(
            onTap: () {
              bloc.onTapUploadFile();
            },
            child: AnimatedSize(
              duration: Duration(seconds: 1),
              child: Container(
                height: bloc.isUploadImage == true ? 0 : kSize50 - 10,
                width: kSize150 - 10,
                padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kMargin6),
                    color: kPrimaryColor),
                child: Row(
                  spacing: kMargin5 - 1,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.kAttachFileLabel ?? '',
                      style: TextStyle(
                          fontSize: AppData.shared.getSmallFontSize(),
                          color: kWhiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      CupertinoIcons.paperclip,
                      color: kWhiteColor,
                      size: kMarginMedium3,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

        ///upload image field
        Consumer<MaintenanceBloc>(builder: (context, bloc, child) {
          return Column(children: [
            bloc.isUploadImage == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)?.kUploadPhotoLabel ?? '',
                        style: TextStyle(
                            fontSize: AppData.shared.getSmallFontSize(),
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '${AppLocalizations.of(context)?.kLimitedPhotoLabel} (${bloc.imageArray.length}/2)',
                        style: TextStyle(
                            fontSize: kTextSmall, fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                : SizedBox(),
            10.vGap,
            bloc.imageArray.isNotEmpty
                ? Column(
                    spacing: kMargin10,
                    children: bloc.imageArray.asMap().entries.map((entry) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(kMargin6),
                          child: _buildImageView(
                              image: entry.value, index: entry.key));
                    }).toList(),
                  )
                : Selector<MaintenanceBloc, bool>(
                    selector: (context, bloc) => bloc.isUploadImage,
                    builder: (context, isUploadImage, child) => AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.decelerate,
                      child: SizedBox(
                        height: isUploadImage == false ? 0 : kSize158,
                        child: Container(
                          height: kSize120 + 10,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(kMarginMedium),
                              color: kInputBackgroundColor),
                          child: Column(
                            spacing: kMarginMedium,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.cloud_upload,
                                color: kPrimaryColor,
                                size: kMargin34,
                              ),
                              Text(
                                '${AppLocalizations.of(context)?.kUploadImageLabel} (jpg)',
                                style: TextStyle(fontSize: kTextSmall),
                              ),
                              Consumer<MaintenanceBloc>(
                                builder: (context, bloc, child) => GestureDetector(
                                  onTap: () => bloc.selectImage(),
                                  child: Container(
                                    width: kSize73,
                                    height: kSize28,
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(kMargin6)),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)
                                                ?.kUploadLabel ??
                                            '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: kWhiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ]);
        })
      ],
    );
  }

  Widget _buildImageView({required File image, required int index}) {
    return Selector<MaintenanceBloc, List<File>>(
      selector: (context, bloc) => bloc.imageArray,
      builder: (context, imageArray, child) => Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
              height: kSize150,
              width: double.infinity,
              child: Image.file(image)),
          Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                  onPressed: () {
                    var bloc = context.read<MaintenanceBloc>();
                    bloc.removeImage(index: index);
                  },
                  icon: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: kWhiteColor, shape: BoxShape.circle),
                    child: Icon(
                      CupertinoIcons.minus_circle_fill,
                      color: Colors.red,
                      size: kMargin24,
                    ),
                  ))),
          Consumer<MaintenanceBloc>(
            builder: (context, bloc, child) => bloc.imageArray.length == 2
                ? SizedBox.shrink()
                : GestureDetector(
                    onTap: () => bloc.selectImage(),
                    child: Center(
                      child: Container(
                        width: kSize100,
                        height: kSize40,
                        decoration: BoxDecoration(
                            color: kGreyColor.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(kMargin10)),
                        child: Center(
                          child: Text(
                            'Add More',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
