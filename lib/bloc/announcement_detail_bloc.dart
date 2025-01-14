import 'package:flutter/widgets.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/announcement_vo.dart';

class AnnouncementDetailBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;
  AnnouncementVO? announcementDetail;
  var token = '';
  var id = '';

  final TmsModel _tmsModel = TmsModelImpl();
  AnnouncementDetailBloc(this.id) {
    token = PersistenceData.shared.getToken();
    getAnnouncementDetail();
  }

  getAnnouncementDetail() {
    _showLoading();
    _tmsModel
        .getAnnouncementDetail(token, id)
        .then((response) => announcementDetail = response)
        .whenComplete(() => _hideLoading());
  }

  _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
