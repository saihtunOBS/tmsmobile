import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/profile_bloc.dart';
import '../utils/colors.dart';
import '../utils/dimens.dart';
import 'cache_image.dart';

class AppbarHeader extends StatelessWidget {
  const AppbarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileBloc(context: context),
      child: Consumer<ProfileBloc>(builder: (context, bloc, child) {
        return Row(
          spacing: kMargin10,
          children: [
            Container(
              width: kMargin40,
              height: kMargin40,
              margin: EdgeInsets.only(left: kMarginMedium2),
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(kMargin5)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(kMargin5),
                  child: cacheImage(bloc.userData?.photo ?? '')),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, ${bloc.userData?.tenantName ?? ''}',
                  style: TextStyle(
                      color: kWhiteColor, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Good Morning',
                  style: TextStyle(
                      color: kWhiteColor, fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        );
      }),
    );
  }
}
