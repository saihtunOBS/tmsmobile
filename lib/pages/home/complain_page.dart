import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

import '../../data/app_data/app_data.dart';
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
  late ComplaintBloc complainBloc;
  @override
  void initState() {
    
    complainBloc = context.read<ComplaintBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      complainBloc.getComplaint(1);
    });

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index != _currentIndex) {
        setState(() {
          _currentIndex = _tabController.index;
          complainBloc.onChangeTab(_currentIndex == 0 ? 1 : 2);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
              AppLocalizations.of(context)?.kCompliantLabel ?? '',
            )),
        body: Consumer<ComplaintBloc>(builder: (context, bloc, child) {
          return Stack(children: [
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
                                    fontSize: AppData.shared.getSmallFontSize(),
                                    fontWeight: FontWeight.w700)),
                          ),
                          Tab(
                            child: Text(
                              kSolvedLabel,
                              style: TextStyle(
                                  fontSize: AppData.shared.getSmallFontSize(),
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
          ]);
        }),
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
                  bloc.getComplaint(_currentIndex == 0 ? 1 : 2);
                });
              }),
        ),
      ),
    );
  }

  Widget _buildPendingTab() {
    return Consumer<ComplaintBloc>(
      builder: (context, bloc, child) => RefreshIndicator(
        backgroundColor: kBackgroundColor,
        elevation: 0.0,
        onRefresh: () async {
          HapticFeedback.mediumImpact();
          bloc.getComplaint(1);
        },
        child: SizedBox(
          height: double.infinity,
          child: bloc.isLoading
              ? LoadingView()
              : bloc.complainList.isEmpty
                  ? Center(
                      child: EmptyView(
                          imagePath: kNoComplainImage,
                          title: AppLocalizations.of(context)
                                  ?.kEmptyComplaintLabel ??
                              '',
                          subTitle: AppLocalizations.of(context)
                                  ?.kThereIsNoComplaintLabel ??
                              ''),
                    )
                  : ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          vertical: kMargin24, horizontal: kMargin24),
                      itemCount: bloc.complainList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                            onTap: () {
                              PageNavigator(ctx: context).nextPage(
                                  page: ComplainDetailPage(
                                isPending: true,
                                complaintId: bloc.complainList[index].id,
                              ));
                            },
                            child: ComplainListItem(
                              isLast: index == bloc.complainList.length - 1,
                              data: bloc.complainList[index],
                            ));
                      }),
        ),
      ),
    );
  }

  Widget _buildSolvedTab() {
    return Consumer<ComplaintBloc>(
      builder: (context, bloc, child) => RefreshIndicator(
        backgroundColor: kBackgroundColor,
        elevation: 0.0,
        onRefresh: () async {
          HapticFeedback.mediumImpact();
          bloc.getComplaint(2);
        },
        child: SizedBox(
          height: double.infinity,
          child: bloc.isLoading
              ? LoadingView()
              : bloc.complainList.isEmpty
                  ? Center(
                      child: EmptyView(
                          imagePath: kNoComplainImage,
                          title: AppLocalizations.of(context)
                                  ?.kEmptyComplaintLabel ??
                              '',
                          subTitle: AppLocalizations.of(context)
                                  ?.kThereIsNoComplaintLabel ??
                              ''),
                    )
                  : ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          vertical: kMargin24, horizontal: kMargin24),
                      itemCount: bloc.complainList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => PageNavigator(ctx: context).nextPage(
                              page: ComplainDetailPage(
                            isPending: false,
                            complaintId: bloc.complainList[index].id,
                          )),
                          child: ComplainListItem(
                            data: bloc.complainList[index],
                            isLast: index == bloc.complainList.length - 1,
                          ),
                        );
                      }),
        ),
      ),
    );
  }
}
