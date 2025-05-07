import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/notification_bloc.dart';

class TabbarBloc extends ChangeNotifier {
  int currentIndex = 0;
  BuildContext? context;

  TabbarBloc({this.context}) {
    context = context;
  }

  void changeIndex(int index) {
    currentIndex = index;
    var notiBloc = context?.read<NotificationBloc>();
    notiBloc?.updateToken();
    notiBloc?.getNotification();
    notifyListeners();
  }
}
