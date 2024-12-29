import 'package:flutter/material.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/contract_list_item.dart';
import 'package:tmsmobile/pages/home/contract_information_page.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';

import '../../utils/images.dart';

class ContractPage extends StatelessWidget {
  const ContractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, kMargin60),
          child: GradientAppBar(kContractLabel)),
      body: Stack(

        children:[ 
          SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            kBillingBackgroundImage,
            fit: BoxFit.fill,
          ),
        ),
          ListView.builder(
            itemCount: 3,
            padding:
                EdgeInsets.symmetric(horizontal: kMargin24),
            itemBuilder: (context, index) {
              return ContractListItem(
                onPress: () => PageNavigator(ctx: context)
                    .nextPage(page: ContractInformationPage()),
              );
            }),]
      ),
    );
  }
}
