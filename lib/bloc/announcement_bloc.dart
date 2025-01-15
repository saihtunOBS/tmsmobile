import 'package:flutter/widgets.dart';
import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/model/tms_model_impl.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/announcement_vo.dart';

class AnnouncementBloc extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;
  List<AnnouncementVO> announcementList = [];
  var token = '';

  final TmsModel _tmsModel = TmsModelImpl();
  AnnouncementBloc() {
    token = PersistenceData.shared.getToken();
    getAnnouncement();
  }

  getAnnouncement() {
    _showLoading();
    _tmsModel
        .getAnnouncements(token)
        .then((response) => announcementList = response)
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
