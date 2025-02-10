// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/complaint_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/widgets/common_dialog.dart';
import 'package:tmsmobile/widgets/error_dialog_view.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import '../../data/app_data/app_data.dart';

import '../../utils/colors.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';
import '../../widgets/gradient_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmitComplainPage extends StatelessWidget {
  SubmitComplainPage({super.key});

  final _complainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ComplaintBloc(),
      child: Material(
        child: InkWell(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: PreferredSize(
                preferredSize: Size(double.infinity, kMargin60),
                child: GradientAppBar(
                  AppLocalizations.of(context)?.kSendCompliantLabel ?? '',
                )),
            body: Selector<ComplaintBloc, bool>(
              selector: (p0, p1) => p1.isSubmitLoading,
              builder: (context, isLoading, child) => Stack(children: [
                _buildTextField(
                    controller: _complainController, context: context),

                //loading
                if (isLoading)
                  Center(
                    child: LoadingView(),
                  )
              ]),
            ),
            bottomNavigationBar: Consumer<ComplaintBloc>(
              builder: (context, bloc, child) => Container(
                  color: kWhiteColor,
                  height: kBottomBarHeight,
                  child: Center(
                    child: gradientButton(
                        title: AppLocalizations.of(context)?.kSubmitLabel,
                        onPress: () {
                          bloc
                              .createComplaint(_complainController.text.trim())
                              .then((_) {
                            Navigator.pop(context);
                          }).catchError((error) {
                            showCommonDialog(
                                context: context,
                                dialogWidget: ErrorDialogView(
                                    errorMessage: error.toString()));
                          });
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
      {required TextEditingController controller, BuildContext? context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kMarginMedium2, vertical: kMarginMedium2),
      child: SingleChildScrollView(
        child: Column(
          spacing: kMargin5 - 1,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 3,
              children: [
                Text(
                  AppLocalizations.of(context!)?.kCompliantLabel ?? '',
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
                maxLines: 15,
                controller: controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: AppLocalizations.of(context)?.kWriteComplainLabel,
                    hintStyle:
                        TextStyle(fontSize: AppData.shared.getSmallFontSize())),
              ),
            ),
            20.vGap,
            //_buildUploadImage()
          ],
        ),
      ),
    );
  }

  Widget _buildUploadImage() {
    return Stack(
      children: [
        Consumer<ComplaintBloc>(
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
        Consumer<ComplaintBloc>(builder: (context, bloc, child) {
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
                    ],
                  )
                : SizedBox(),
            10.vGap,
            bloc.image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(kMargin6),
                    child: _buildImageView(image: bloc.image!))
                : Selector<ComplaintBloc, bool>(
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
                              Consumer<ComplaintBloc>(
                                builder: (context, bloc, child) => InkWell(
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

  Widget _buildImageView({required File image}) {
    return Selector<ComplaintBloc, File?>(
      selector: (context, bloc) => bloc.image,
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
                    var bloc = context.read<ComplaintBloc>();
                    bloc.removeImage();
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
        ],
      ),
    );
  }
}
