import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/extension/route_navigator.dart';
import 'package:tmsmobile/pages/profile/change_profile_page.dart';
import '../bloc/profile_bloc.dart';
import '../data/persistance_data/persistence_data.dart';
import '../utils/colors.dart';
import '../utils/dimens.dart';
import 'cache_image.dart';

class AppbarHeader extends StatelessWidget {
  const AppbarHeader({super.key, this.action});
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileBloc(context: context),
      child: Consumer<ProfileBloc>(builder: (context, bloc, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                PageNavigator(ctx: context)
                    .nextPage(
                        page: ChangeProfilePage(
                    ))
                    .whenComplete(() => bloc.getUser());
              },
              child: Row(
                spacing: kMargin10,
                children: [
                  Container(
                    width: kMargin40,
                    height: kMargin40,
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(kMargin5)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(kMargin5),
                        child: cacheImage(PersistenceData.shared.getUser()?.photo ?? '')),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hi, ${PersistenceData.shared.getUser()?.tenantName ?? ''}',
                        style: TextStyle(
                          fontSize: kTextRegular,
                            color: kWhiteColor, fontWeight: FontWeight.w600),
                      ),
                      3.vGap,
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          fontSize: kTextRegular,
                            color: kWhiteColor, fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ),
        
            //action widget
            action ?? Text('')
          ],
        );
      }),
    );
  }
}
