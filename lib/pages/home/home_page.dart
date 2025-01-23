import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Stack(children: [
          Positioned(bottom: kMargin10 + 4, child: AppbarHeader())
        ]),
      ),
      body: Stack(
        children: [
          GridView.builder(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.only(
                  left: kMarginXLarge,
                  right: kMarginXLarge,
                  top: MediaQuery.of(context).size.height * 0.45,
                  bottom: MediaQuery.of(context).size.height * 0.15),
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kMargin45,
                  crossAxisSpacing: kMarginMedium3,
                  mainAxisExtent: kSize75),
              itemBuilder: (context, index) {
                return InkWell(
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: _buildBannerView(context),
          ),
        ],
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

  Widget _buildBannerView(BuildContext context) {
    final ValueNotifier<int> sliderIndex = ValueNotifier(0);
    final CarouselSliderController controller = CarouselSliderController();
    final double bannerHeight = MediaQuery.of(context).size.height * 0.2;
    return ValueListenableBuilder(
      valueListenable: sliderIndex,
      builder: (context, value, child) {
        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                kAppBarBackgroundImage,
                fit: BoxFit.fill,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kSize80.vGap,
                SizedBox(
                  height: bannerHeight,
                  width: double.infinity,
                  child: CarouselSlider(
                      carouselController: controller,
                      items: bannerArray.map((value) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMarginMedium2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(kMarginMedium),
                            child: cacheImage(
                                'https://hanoirealestate.com.vn/images/products/modern-3-bedroom-apartment-with-large-balcony-on-to-ngoc-van_2024581453612.jpg'),
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        autoPlay: true,
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
                    count: bannerArray.length),
              ],
            ),
          ],
        );
      },
    );
  }
}
