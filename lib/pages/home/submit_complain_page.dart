// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/complaint_bloc.dart';
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
                _buildTextField(controller: _complainController,context: context),
          
                //loading
                if (isLoading)
                  Center(
                    child: LoadingView(
                        indicator: Indicator.ballBeat,
                        indicatorColor: kPrimaryColor),
                  )
              ]),
            ),
            bottomNavigationBar: Consumer<ComplaintBloc>(
              builder: (context, bloc, child) => Container(
                  color: kWhiteColor,
                  height: kBottomBarHeight,
                  child: Center(
                    child: gradientButton(
                        title:AppLocalizations.of(context)?.kSubmitLabel,
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
                        },context: context),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,BuildContext? context
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kMarginMedium2, vertical: kMarginMedium2),
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
                    fontSize: AppData.shared.getSmallFontSize(), fontWeight: FontWeight.w600),
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
                  border: InputBorder.none, hintText:AppLocalizations.of(context)?.kWriteComplainLabel),
            ),
          )
        ],
      ),
    );
  }
}
