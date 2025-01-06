import 'package:flutter/cupertino.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/user_vo.dart';

import '../data/model/tms_model.dart';
import '../data/model/tms_model_impl.dart';

class ProfileBloc extends ChangeNotifier {
  String? token;
  UserVO? userData;
  final TmsModel _tmsModel = TmsModelImpl();

  ProfileBloc() {
    token = PersistenceData.shared.getToken();

    _tmsModel.getUser(token ?? '').then((response) {
      userData = response;
      notifyListeners();
    });
  }
}
