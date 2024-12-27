import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/utils/strings.dart';
import '../../utils/dimens.dart';
import '../../widgets/appbar.dart';

class ComplainDetailPage extends StatelessWidget {
  const ComplainDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: GradientAppBar(
            kDetailLabel,
          )),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [kMargin24.vGap, _buildHeader(context), _buildBody()]),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      child: Column(
        spacing: kMargin10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Row(
                  spacing: kMargin10,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          kLogoFrameImage,
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          kAppLogoImage,
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Steve',
                          style: TextStyle(
                              fontSize: kTextRegular2x,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Customer Service',
                          style: TextStyle(
                            fontSize: kTextRegular,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () => _showAlertDialog(context),
                child: Container(
                  width: 71,
                  height: 34,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(kMargin6)),
                  child: Center(
                    child: Text(
                      kRatingLabel,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: kWhiteColor),
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kMarginMedium2, vertical: kMargin10),
      child: Column(
        spacing: kMargin5 - 1,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kCompliantLabel,
            style: GoogleFonts.crimsonPro(
                fontWeight: FontWeight.w700, fontSize: kTextRegular3x),
          ),
          Text(
            'We will arrive within 2 day.....',
            style: TextStyle(
              fontSize: kTextRegular,
            ),
          ),
        ],
      ),
    );
  }

  
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300, // Set the custom width
            height: 200, // Set the custom height
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              
              children: <Widget>[
                Text(
                  'Custom Sized Dialog',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'This is an alert dialog with custom width and height.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
