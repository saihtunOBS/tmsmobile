import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tmsmobile/data/dummy/dummy.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/list_items/home_list_item.dart';
import 'package:tmsmobile/pages/home/billing_page.dart';
import 'package:tmsmobile/pages/home/complain_page.dart';
import 'package:tmsmobile/pages/home/contract_page.dart';
import 'package:tmsmobile/pages/home/service_request_page.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';
import 'package:tmsmobile/utils/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.4,
            width: double.infinity,
            child: _buildBannerView(),
          ),
          Expanded(
              child: GridView.builder(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: kMargin24, vertical: kMargin30 + 5),
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: kMargin45,
                      crossAxisSpacing: kMarginMedium3,
                      mainAxisExtent: 75),
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
                            break;

                          default:
                        }
                      },
                      child: HomeListItem(
                        backgroundColor: _separateColor(index),
                        label: _separateLabel(index),
                        imageLogo: _separateLogo(index),
                      ),
                    );
                  }))
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

  String _separateLabel(int index) {
    switch (index) {
      case 0:
        return kContractLabel;
      case 1:
        return kBillingLabel;
      case 2:
        return kServiceRequestLabel;
      case 3:
        return kCompliantLabel;
      case 4:
        return kParkingLabel;
      case 5:
        return kAnnouncementLabel;
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

  Widget _buildBannerView() {
    final ValueNotifier<int> sliderIndex = ValueNotifier(0);
    final CarouselSliderController controller = CarouselSliderController();

    return ValueListenableBuilder(
      valueListenable: sliderIndex,
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                kAppBarBackgroundImage,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: kMargin45 + 13),
              height: MediaQuery.of(context).size.height * 0.21,
              width: double.infinity,
              child: CarouselSlider(
                  carouselController: controller,
                  items: bannerArray.map((value) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kMargin24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kMarginMedium),
                        child: Image.asset(
                          value,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) => sliderIndex.value = index,
                  )),
            ),
            Positioned(
                bottom: kMargin34 + 4,
                child: AnimatedSmoothIndicator(
                    effect: ExpandingDotsEffect(
                        dotHeight: kMargin6,
                        dotWidth: kMargin6,
                        activeDotColor: kWhiteColor),
                    activeIndex: sliderIndex.value,
                    count: bannerArray.length)),
            Positioned(
                top: kMargin50 + 10, left: kMargin24, child: _buildHeader()),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      spacing: 10,
      children: [
        Container(
          width: kMargin40,
          height: kMargin40,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(kMargin5)),
          child: Center(
            child: Image.asset(kAppLogoImage),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, John',
              style: TextStyle(color: kWhiteColor),
            ),
            Text(
              'Good Morning',
              style: TextStyle(color: kWhiteColor),
            )
          ],
        )
      ],
    );
  }
}
