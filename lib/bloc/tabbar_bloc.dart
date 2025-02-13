import 'package:flutter/material.dart';

class TabbarBloc extends ChangeNotifier {
  int currentIndex = 0;
  BuildContext? context;

  TabbarBloc({this.context}){
    context = context;
  }

  void changeIndex(int index){
    currentIndex = index;
    notifyListeners();
  }
}