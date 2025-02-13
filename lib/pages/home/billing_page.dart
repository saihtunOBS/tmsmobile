import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/billing_bloc.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/billing_list_item.dart';
import 'package:tmsmobile/pages/home/billing_invoice_page.dart';
import 'package:tmsmobile/pages/home/invoice_detail_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/empty_view.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BillingBloc(),
      child: Container(
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
                AppLocalizations.of(context)?.kBillingLabel ?? '',
                action: _buildDropDown(),
              )),
          body: Consumer<BillingBloc>(
            builder: (context, bloc, child) => RefreshIndicator(
              backgroundColor: kBackgroundColor,
              elevation: 0.0,
              onRefresh: () async {
                HapticFeedback.mediumImpact();
                bloc.getBilling(type: bloc.selectedOption);
              },
              child: bloc.isLoading == true
                  ? LoadingView()
                  : bloc.billingLists.isEmpty
                      ? EmptyView(
                          imagePath: kNoAnnouncementImage,
                          title:
                              AppLocalizations.of(context)?.kNoBillingLabel ??
                                  '',
                          subTitle: AppLocalizations.of(context)
                                  ?.kThereIsNoBillingLabel ??
                              '')
                      : ListView.builder(
                          itemCount: bloc.billingLists.length,
                          padding: EdgeInsets.symmetric(
                              horizontal: kMargin24 - 2,
                              vertical: kMarginMedium3 - 2),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => bloc.billingLists[index].status == 0
                                  ? PageNavigator(ctx: context)
                                      .nextPage(page: InvoiceDetailPage(billingData: bloc.billingLists[index],))
                                  : PageNavigator(ctx: context).nextPage(
                                      page: BillingInvoicePage(
                                      status:
                                          bloc.billingLists[index].status ?? 0,
                                      data: bloc.billingLists[index],
                                    )),
                              child: BillingListItem(
                                biling: bloc.billingLists[index],
                              ),
                            );
                          }),
            ),
          ),
        ),
      ),
    );
  }

  List<String> billingTypeArray = ['All', 'Paid', 'Unpaid'];

  Widget _buildDropDown() {
    return Consumer<BillingBloc>(
      builder: (context, bloc, child) => Container(
          height: kSize33,
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
              value: bloc.selectedOption,
              items: billingTypeArray.map((value) {
                return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ));
              }).toList(),
              onChanged: (value) {
                bloc.onChangeDropDown(value);
              })),
    );
  }
}
