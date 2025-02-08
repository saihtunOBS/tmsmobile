import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/images.dart';

Widget cacheImage(
  String url,
) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: BoxFit.cover,
    placeholder: (context, url) => Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        baseColor: kGreyColor,
        highlightColor: kWhiteColor,
        child: Container(
          color: kGreyColor,
        )),
        errorWidget: (context, url, error) => Image.asset(kPlaceholderImage,fit: BoxFit.cover,),
  );
}
