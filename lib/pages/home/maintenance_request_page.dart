import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/maintenance_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';

import '../../widgets/appbar.dart';
import '../../widgets/gradient_button.dart';

class MaintenanceRequestPage extends StatefulWidget {
  const MaintenanceRequestPage({super.key});

  @override
  State<MaintenanceRequestPage> createState() => _MaintenanceRequestPageState();
}

class _MaintenanceRequestPageState extends State<MaintenanceRequestPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedRoomShopName;
  String? _selectedTypeIssue;

  @override
  void initState() {
    _nameController.text = 'Simon';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MaintenanceBloc(),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 60),
            child: GradientAppBar(
              kMaintenanceRequestLabel,
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kMarginMedium2, vertical: kMarginMedium2),
            child: Column(
              spacing: kMargin10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                    maxLine: 1,
                    controller: _nameController,
                    title: kTenantNameLabel,
                    hint: 'Naame'),
                _buildRoomShopNameDropDown(),
                _buildTypeIssueDropDown(),
                _buildTextField(
                    maxLine: 5,
                    controller: _descriptionController,
                    title: kDescriptionLabel,
                    hint: kWriteDescriptionHereLabel),
                _buildUploadImage(),
                1.vGap
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
            height: kBottomBarHeight,
            child: Center(
              child: gradientButton(title: kSendRequestLabel, onPress: () {
              }),
            )),
      ),
    );
  }

  Widget _buildTextField(
      {required int maxLine,
      required TextEditingController controller,
      required String title,
      required String hint}) {
    return Column(
      spacing: kMargin5 - 1,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 3,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
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
            decoration:
                InputDecoration(border: InputBorder.none, hintText: hint),
          ),
        )
      ],
    );
  }

  List<String> rooms = ['#C001', '#C002', '#C003'];
  Widget _buildRoomShopNameDropDown() {
    return Column(
      spacing: kMargin5 - 1,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 3,
          children: [
            Text(
              kRoomShopNameLabel,
              style: TextStyle(
                  fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
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
          child: DropdownButton(
              value: _selectedRoomShopName,
              isExpanded: true,
              underline: Container(),
              hint: Text(kSelectRoomShopLabel),
              items: rooms.map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: ((value) {
                setState(() {
                  _selectedRoomShopName = value ?? '';
                });
              })),
        )
      ],
    );
  }

  List<String> issues = ['#C001', '#C002', '#C003'];
  Widget _buildTypeIssueDropDown() {
    return Column(
      spacing: kMargin5 - 1,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 3,
          children: [
            Text(
              kTypeOfIssueLabel,
              style: TextStyle(
                  fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
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
          child: DropdownButton(
              value: _selectedTypeIssue,
              isExpanded: true,
              underline: Container(),
              hint: Text(kSelectTypeIssueLabel),
              items: issues.map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: ((value) {
                setState(() {
                  _selectedTypeIssue = value ?? '';
                });
              })),
        )
      ],
    );
  }

  Widget _buildUploadImage() {
    return Stack(
      children: [
        Consumer<MaintenanceBloc>(
          builder: (context, bloc, child) => InkWell(
            onTap: () {
              bloc.onTapUploadFile();
            },
            child: AnimatedSize(
              duration: Duration(seconds: 1),
              child: Container(
                height: bloc.isUploadImage == true ? 0 : 40,
                width: 140,
                padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kMargin6),
                    color: kPrimaryColor),
                child: Row(
                  spacing: kMargin5 - 1,
                  children: [
                    Text(
                      kAttachFileLabel,
                      style: TextStyle(
                          fontSize: kTextRegular2x,
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
                        kUploadPhotoLabel,
                        style: TextStyle(
                            fontSize: kTextRegular2x,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '$kLimitedPhotoLabel (${bloc.imageArray.length}/2)',
                        style: TextStyle(fontSize: kTextSmall),
                      )
                    ],
                  )
                : SizedBox(),
            10.vGap,
            bloc.imageArray.isNotEmpty
                ? Column(
                    spacing: kMargin10,
                    children: bloc.imageArray.asMap().entries.map((value) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(kMargin6),
                          child: _buildImageView(
                              image: value.value, index: value.key));
                    }).toList(),
                  )
                : Selector<MaintenanceBloc, bool>(
                    selector: (context, bloc) => bloc.isUploadImage,
                    builder: (context, isUploadImage, child) => AnimatedSize(
                      duration: Duration(milliseconds: 700),
                      curve: Curves.decelerate,
                      child: SizedBox(
                        height: isUploadImage == false ? 0 : 158,
                        child: Container(
                          height: 130,
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
                                kUploadImageLabel,
                                style: TextStyle(fontSize: kTextSmall),
                              ),
                              Consumer<MaintenanceBloc>(
                                builder: (context, bloc, child) => InkWell(
                                  onTap: () => bloc.selectImage(),
                                  child: Container(
                                    width: 73,
                                    height: 28,
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(kMargin6)),
                                    child: Center(
                                      child: Text(
                                        kUploadLabel,
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
              height: 150,
              width: double.infinity,
              child: Image.file(image, fit: BoxFit.cover)),
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
                : InkWell(
                    onTap: () => bloc.selectImage(),
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 40,
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
