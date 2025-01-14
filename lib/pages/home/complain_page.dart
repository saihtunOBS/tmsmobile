import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/complaint_bloc.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/complain_list_item.dart';
import 'package:tmsmobile/pages/home/complain_detail_page.dart';
import 'package:tmsmobile/pages/home/submit_complain_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/utils/strings.dart';
import 'package:tmsmobile/widgets/appbar.dart';
import 'package:tmsmobile/widgets/empty_view.dart';
import 'package:tmsmobile/widgets/loading_view.dart';

import '../../utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ComplainPage extends StatefulWidget {
  const ComplainPage({super.key});

  @override
  State<ComplainPage> createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index != _currentIndex) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ComplaintBloc(),
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
                kCompliantLabel,
              )),
          body: Stack(children: [
            Column(
              children: [
                DefaultTabController(
                    length: 2,
                    child: TabBar(
                        dividerColor: Colors.transparent,
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: EdgeInsets.only(
                            top: kMargin45, left: kMargin24, right: kMargin24),
                        indicatorWeight: 4.0,
                        indicator: ShapeDecoration(
                          shape: UnderlineInputBorder(),
                          gradient: LinearGradient(
                            colors: [kPrimaryColor, kThirdColor],
                          ),
                        ),
                        tabs: [
                          Tab(
                            child: Text(kPendingLabel,
                                style: TextStyle(
                                    fontSize: kTextRegular2x,
                                    fontWeight: FontWeight.w700)),
                          ),
                          Tab(
                            child: Text(
                              kSolvedLabel,
                              style: TextStyle(
                                  fontSize: kTextRegular2x,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ])),
                Expanded(
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [_buildPendingTab(), _buildSolvedTab()]),
                ),
              ],
            )
          ]),
          floatingActionButton: Consumer<ComplaintBloc>(
            builder: (context, bloc, child) => FloatingActionButton(
                shape: CircleBorder(),
                backgroundColor: kPrimaryColor,
                child: Center(
                  child: Icon(
                    Icons.edit,
                    color: kWhiteColor,
                  ),
                ),
                onPressed: () {
                  PageNavigator(ctx: context)
                      .nextPage(page: SubmitComplainPage())
                      .whenComplete(() {
                    bloc.getComplaint();
                  });
                }),
          ),
        ),
      ),
    );
  }

  Widget _buildPendingTab() {
    return Consumer<ComplaintBloc>(
      builder: (context, bloc, child) => bloc.isLoading
          ? LoadingView(
              indicator: Indicator.ballBeat, indicatorColor: kPrimaryColor)
          : bloc.pendingComplainList.isEmpty
              ? Center(
                  child: EmptyView(
                      imagePath: kNoComplainImage,
                      title:
                          AppLocalizations.of(context)?.kEmptyComplaintLabel ??
                              '',
                      subTitle: AppLocalizations.of(context)
                              ?.kThereIsNoComplaintLabel ??
                          ''),
                )
              : SizedBox(
                  height: double.infinity,
                  child: RefreshIndicator(
                    onRefresh: () async => bloc.getComplaint(),
                    child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            vertical: kMargin24, horizontal: kMargin24),
                        itemCount: bloc.pendingComplainList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                PageNavigator(ctx: context).nextPage(
                                    page: ComplainDetailPage(
                                  isPending: true,
                                  complaintId: bloc.pendingComplainList[index].id,
                                ));
                              },
                              child: ComplainListItem(
                                isLast:
                                    index == bloc.pendingComplainList.length - 1,
                                data: bloc.pendingComplainList[index],
                              ));
                        }),
                  ),
                ),
    );
  }

  Widget _buildSolvedTab() {
    return Consumer<ComplaintBloc>(
      builder: (context, bloc, child) => bloc.isLoading
          ? LoadingView(
              indicator: Indicator.ballBeat, indicatorColor: kPrimaryColor)
          : bloc.solvedComplainList.isEmpty
              ? Center(
                  child: EmptyView(
                      imagePath: kNoComplainImage,
                      title:
                          AppLocalizations.of(context)?.kEmptyComplaintLabel ??
                              '',
                      subTitle: AppLocalizations.of(context)
                              ?.kThereIsNoComplaintLabel ??
                          ''),
                )
              : SizedBox(
                height: double.infinity,
                child: RefreshIndicator(
                  onRefresh: () async => bloc.getComplaint(),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          vertical: kMargin24, horizontal: kMargin24),
                      itemCount: bloc.solvedComplainList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => PageNavigator(ctx: context).nextPage(
                              page: ComplainDetailPage(
                            isPending: false,
                            complaintId: bloc.solvedComplainList[index].id,
                          )),
                          child: ComplainListItem(
                            data: bloc.solvedComplainList[index],
                            isLast: index == bloc.solvedComplainList.length - 1,
                          ),
                        );
                      }),
                ),
              ),
    );
  }
}
