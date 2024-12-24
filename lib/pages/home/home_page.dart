import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tmsmobile/data/dummy/dummy.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/images.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.4,
            width: double.infinity,
            child: _buildBannerView(),
          ),
          // Expanded(
          //     child: ListView.builder(
          //         shrinkWrap: true,
          //         itemBuilder: (context, index) {
          //           return Container();
          //         }))
        ],
      ),
    );
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
              height: 180,
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
                top: kMargin50, left: kMargin24, child: _buildHeader()),
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
