import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tmsmobile/bloc/banner_bloc.dart';
import 'package:tmsmobile/bloc/epc_bloc.dart';
import 'package:tmsmobile/data/dummy/dummy.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/home_list_item.dart';
import 'package:tmsmobile/pages/home/announcement_page.dart';
import 'package:tmsmobile/pages/home/billing_page.dart';
import 'package:tmsmobile/pages/home/car_parking_page.dart';
import 'package:tmsmobile/pages/home/complain_page.dart';
import 'package:tmsmobile/pages/home/contract_page.dart';
import 'package:tmsmobile/pages/home/service_request_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/widgets/appbar_header.dart';
import 'package:tmsmobile/widgets/cache_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tmsmobile/widgets/image_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EpcBloc>().getEpc();
      if (Platform.isAndroid) {
        //updateNewVersion();
      }
    });
  }

  // updateNewVersion() async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           child: SizedBox(
  //             height: 150,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text('Download new version?.'),
  //                 20.vGap,
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     ElevatedButton(
  //                         onPressed: () async {
  //                           await launchUrl(Uri.parse(
  //                               'https://drive.google.com/file/d/11NU9SfXuvqP-nY7z-oc8ZlAFHAZYdMoy/view?usp=sharing'));
  //                         },
  //                         child: Text('Ok')),
  //                     20.hGap,
  //                     ElevatedButton(
  //                         onPressed: () {
  //                           Navigator.pop(context);
  //                         },
  //                         child: Text('Cancel'))
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  //}

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BannerBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: AppbarHeader(
            action: _alertView(),
          ),
          // flexibleSpace: AppbarHeader(
          //   action: _alertView(),
          // ),
        ),
        body: Consumer<BannerBloc>(
          builder: (context, bloc, child) => Column(
            children: [
              // banner
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.415,
                width: double.infinity,
                child: Stack(children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      kAppBarBackgroundImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity:
                        bloc.isLoading ? 0.0 : 1.0, // Fully hidden when loading
                    duration: Duration(milliseconds: 500),
                    child: bloc.isLoading
                        ? SizedBox.shrink()
                        : _buildBannerView(context, bloc),
                  )
                ]),
              ),

              6.vGap,
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    HapticFeedback.mediumImpact();
                    await bloc.getBanner();
                    // ignore: use_build_context_synchronously
                    var epcBloc = context.read<EpcBloc>();
                    await epcBloc.getEpc();
                  },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            left: kMarginXLarge,
                            right: kMarginXLarge,
                            top: 35,
                            bottom: 100),
                        shrinkWrap: true,
                        itemCount: 6,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: kMargin45,
                                crossAxisSpacing: kMarginMedium3,
                                mainAxisExtent: kSize75),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  PageNavigator(ctx: context)
                                      .nextPage(page: ContractPage());
                                case 1:
                                  PageNavigator(ctx: context)
                                      .nextPage(page: BillingPage());
                                case 2:
                                  PageNavigator(ctx: context)
                                      .nextPage(page: ServiceRequestPage());
                                case 3:
                                  PageNavigator(ctx: context)
                                      .nextPage(page: ComplainPage());
                                case 4:
                                  PageNavigator(ctx: context)
                                      .nextPage(page: CarParkingPage());
                                case 5:
                                  PageNavigator(ctx: context)
                                      .nextPage(page: AnnouncementPage());
                                  break;

                                default:
                              }
                            },
                            child: HomeListItem(
                              backgroundColor: _separateColor(index),
                              label: _separateLabel(index, context),
                              imageLogo: _separateLogo(index),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _separateColor(int index) {
    switch (index) {
      case 0:
        return kPrimaryColor;
      case 1:
        return kSecondaryColor;
      case 2:
        return kSecondaryColor;
      case 3:
        return kPrimaryColor;
      case 4:
        return kPrimaryColor;
      case 5:
        return kSecondaryColor;
      default:
        return kPrimaryColor;
    }
  }

  String _separateLabel(int index, BuildContext context) {
    switch (index) {
      case 0:
        return AppLocalizations.of(context)?.kContractLabel ?? '';
      case 1:
        return AppLocalizations.of(context)?.kBillingLabel ?? '';
      case 2:
        return AppLocalizations.of(context)?.kServiceRequestLabel ?? '';
      case 3:
        return AppLocalizations.of(context)?.kCompliantLabel ?? '';
      case 4:
        return AppLocalizations.of(context)?.kParkingLabel ?? '';
      case 5:
        return AppLocalizations.of(context)?.kAnnouncementLabel ?? '';
      default:
        return '';
    }
  }

  String _separateLogo(int index) {
    switch (index) {
      case 0:
        return kContractImage;
      case 1:
        return kBillingImage;
      case 2:
        return kMaintenanceImage;
      case 3:
        return kCompliantImage;
      case 4:
        return kParkingImage;
      case 5:
        return kAnnouncementImage;
      default:
        return '';
    }
  }

  Widget _buildBannerView(BuildContext context, BannerBloc bloc) {
    final ValueNotifier<int> sliderIndex = ValueNotifier(0);
    final CarouselSliderController controller = CarouselSliderController();
    final double bannerHeight = Platform.isAndroid
        ? MediaQuery.of(context).size.height * 0.21
        : MediaQuery.of(context).size.height * 0.2;
    return ValueListenableBuilder(
      valueListenable: sliderIndex,
      builder: (context, value, child) {
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: Platform.isAndroid
                        ? MediaQuery.of(context).size.height * 0.09
                        : MediaQuery.of(context).size.height * 0.1),
                //80.vGap,
                SizedBox(
                  height: bannerHeight,
                  width: double.infinity,
                  child: CarouselSlider(
                      carouselController: controller,
                      items: bloc.bannerResponse?.data?.photos?.isEmpty ?? true
                          ? bannerArray.map((value) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kMarginMedium2),
                                child: GestureDetector(
                                  onTap: () => showDialogImage(context, value),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(kMarginMedium),
                                    child: cacheImage(value),
                                  ),
                                ),
                              );
                            }).toList()
                          : bloc.bannerResponse?.data?.photos?.map((value) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kMarginMedium2),
                                child: GestureDetector(
                                  onTap: () => showDialogImage(context, value),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(kMarginMedium),
                                    child: cacheImage(value),
                                  ),
                                ),
                              );
                            }).toList(),
                      options: CarouselOptions(
                        autoPlay: false,
                        disableCenter: true,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) =>
                            sliderIndex.value = index,
                      )),
                ),
                14.vGap,
                AnimatedSmoothIndicator(
                    effect: ExpandingDotsEffect(
                        dotHeight: kMargin6,
                        dotWidth: kMargin6,
                        activeDotColor: kWhiteColor),
                    activeIndex: sliderIndex.value,
                    count: bloc.bannerResponse?.data?.photos?.isEmpty ?? true
                        ? bannerArray.length
                        : bloc.bannerResponse?.data?.photos?.length ?? 0),
              ],
            ),
          ],
        );
      },
    );
  }

  //marquee view
  Widget _alertView() {
    return Consumer<EpcBloc>(
      builder: (context, bloc, child) => bloc.isLoading == true
          ? Shimmer.fromColors(
              baseColor: kGreyColor,
              highlightColor: kWhiteColor,
              child: Container(
                height: 28,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: kGreyColor,
                ),
              ))
          : Container(
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: kWhiteColor,
              ),
              child: Row(
                children: [
                  Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: bloc.epcResponse?.data?.isEmpty ?? true
                            ? kRedColor
                            : bloc.epcResponse?.data?.first.switchState == 0
                                ? kRedColor
                                : kGreenColor),
                    child: Center(
                      child: Icon(
                        Icons.light_mode,
                        color: kWhiteColor,
                        size: 16,
                      ),
                    ),
                  ),
                  6.hGap,
                  Text(
                    bloc.epcResponse?.data?.isEmpty ?? true
                        ? 'ယခုမီးပျက်နေပါသည်'
                        : bloc.epcResponse?.data?.first.switchState == 0
                            ? 'ယခုမီးပျက်နေပါသည်'
                            : 'ယခုမီးလာနေပါသည်',
                    style: TextStyle(
                        color: bloc.epcResponse?.data?.isEmpty ?? true
                            ? kRedColor
                            : bloc.epcResponse?.data?.first.switchState == 0
                                ? kRedColor
                                : Colors.black,
                        fontSize: 11.5),
                  ),
                  12.hGap
                ],
              ),
            ),
    );
  }
}
