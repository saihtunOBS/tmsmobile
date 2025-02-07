import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        return Padding(
          padding: const EdgeInsets.only(top: 40,left: kMarginMedium2,right: kMarginMedium2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
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
                ),
              ),
          
              //action widget
              action ?? Text('')
            ],
          ),
        );
      }),
    );
  }
}
