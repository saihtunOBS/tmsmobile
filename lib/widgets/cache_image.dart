import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmsmobile/utils/colors.dart';

Widget cacheImage(
  String url,
) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: BoxFit.cover,
    placeholder: (context, url) => Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        baseColor: kBackgroundColor,
        highlightColor: const Color.fromARGB(255, 178, 175, 175),
        child: Container(
          color: kGreyColor,
        )),
    errorWidget: (context, url, error) => Image.network(
      'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
      fit: BoxFit.fill,
    ),
  );
}
