import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/utils/colors.dart';


Widget cacheImage(String url,) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: BoxFit.cover,
    placeholder: (context, url) => CupertinoActivityIndicator(
      animating: true,
      color: kSecondaryColor,
    ),
    errorWidget: (context, url, error) => Image.network(
      'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
      fit: BoxFit.fill,
    ),
  );
}
