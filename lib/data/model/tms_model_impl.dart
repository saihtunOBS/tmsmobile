import 'package:tmsmobile/data/model/tms_model.dart';

class TmsModelImpl extends TmsModel {
  static final TmsModelImpl _singleton = TmsModelImpl._internal();

  factory TmsModelImpl() {
    return _singleton;
  }

  TmsModelImpl._internal();
}
