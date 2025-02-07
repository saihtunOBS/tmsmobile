import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/network/responses/banner_response.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

class BannerBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;
  final TmsModel _tmsModel = TmsModelImpl();
  BuildContext? context;
  BannerResponse? bannerResponse;

  BannerBloc({this.context}) {
    var token = PersistenceData.shared.getToken();
   _tmsModel.getBannerLists(token).then((response){
    bannerResponse = response;
    notifyListeners();
   });
  }
  

}
