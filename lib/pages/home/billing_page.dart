import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/billing_list_item.dart';
import 'package:tmsmobile/pages/home/billing_invoice_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  String? _selectedOption = 'All';

  @override
  Widget build(BuildContext context) {
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
              kBillingLabel,
              action: _buildDropDown(),
            )),
        body: Stack(children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              kBillingBackgroundImage,
              fit: BoxFit.fill,
            ),
          ),
          ListView.builder(
              itemCount: 2,
              padding: EdgeInsets.symmetric(
                  horizontal: kMargin24 - 2, vertical: kMarginMedium3 - 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => PageNavigator(ctx: context)
                      .nextPage(page: BillingInvoicePage()),
                  child: BillingListItem(
                    statusColor: 2,
                    status: 'Paid',
                  ),
                );
              }),
        ]),
      ),
    );
  }

  List<String> billingTypeArray = ['All', 'Paid', 'Unpaid'];

  Widget _buildDropDown() {
    return Container(
        height: kSize33,
        //padding: EdgeInsets.symmetric(horizontal: kMargin10),
        margin: EdgeInsets.only(right: kMargin24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kMargin6),
            border: Border.all(color: kWhiteColor)),
        child: DropdownButton(
            iconDisabledColor: kWhiteColor,
            iconEnabledColor: kWhiteColor,
            underline: SizedBox(),
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: kMargin5),
            selectedItemBuilder: (context) {
              return billingTypeArray
                  .map((e) => Container(
                        alignment: Alignment.center,
                        child: Text(
                          e,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: kTextRegular),
                        ),
                      ))
                  .toList();
            },
            value: _selectedOption,
            items: billingTypeArray.map((value) {
              return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black),
                  ));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
            }));
  }
}
