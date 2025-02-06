import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/contract_bloc.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/contract_list_item.dart';
import 'package:tmsmobile/pages/home/contract_information_page.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/widgets/empty_view.dart';
import 'package:tmsmobile/widgets/loading_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/colors.dart';
import '../../utils/images.dart';

class ContractPage extends StatefulWidget {
  const ContractPage({super.key});

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContractBloc(),
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
                  AppLocalizations.of(context)?.kContractLabel ?? '')),
          body: Consumer<ContractBloc>(
            builder: (context, bloc, child) => RefreshIndicator(
              backgroundColor: kBackgroundColor,
              elevation: 0.0,
              onRefresh: () async {
                HapticFeedback.mediumImpact();
                bloc.getContract();
              },
              child: bloc.isLoading == true
                  ? LoadingView()
                  : bloc.contracts.isEmpty
                      ? EmptyView(
                          imagePath: kNoAnnouncementImage,
                          title:
                              AppLocalizations.of(context)?.kNoContractLabel ??
                                  '',
                          subTitle: AppLocalizations.of(context)
                                  ?.kThereIsNoContractLabel ??
                              '')
                      : SizedBox(
                          height: double.infinity,
                          child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: bloc.isLoadMore
                                ? bloc.contracts.length + 1
                                : bloc.contracts.length,
                            padding:
                                EdgeInsets.symmetric(horizontal: kMargin24),
                            itemBuilder: (context, index) {
                              if (index == bloc.contracts.length) {
                                return LoadingView(
                                  bgColor: Colors.transparent,
                                );
                              }
                              return ContractListItem(
                                onPress: () =>
                                    PageNavigator(ctx: context).nextPage(
                                        page: ContractInformationPage(
                                  id: bloc.contracts[index].id ?? '',
                                  type:
                                      bloc.contracts[index].propertyType ?? '',
                                )),
                                data: bloc.contracts[index],
                              );
                            },
                            controller: scrollController
                              ..addListener(() {
                                if (scrollController.position.pixels ==
                                    scrollController.position.maxScrollExtent) {
                                  bloc.loadMoreData();
                                }
                              }),
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
