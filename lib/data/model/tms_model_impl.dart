import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/household_vo.dart';
import 'package:tmsmobile/data/vos/login_data_vo.dart';
import 'package:tmsmobile/data/vos/user_vo.dart';
import 'package:tmsmobile/network/data_agents/tms_data_agent.dart';
import 'package:tmsmobile/network/requests/change_password_request.dart';
import 'package:tmsmobile/network/requests/login_request.dart';
import 'package:tmsmobile/network/responses/login_response.dart';

import '../../network/data_agents/retrofit_data_agent_impl.dart';

class TmsModelImpl extends TmsModel {
  static final TmsModelImpl _singleton = TmsModelImpl._internal();

  factory TmsModelImpl() {
    return _singleton;
  }

  TmsModelImpl._internal();
  TmsDataAgent tmsDataAgent = RetrofitDataAgentImpl();

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return tmsDataAgent.login(loginRequest).then((response) async {
      var loginResponse = LoginDataVO(
          id: response.data?.id ?? '',
          verify: response.data?.verify ?? 0,
          phoneNo: response.data?.phoneNo,
          email: response.data?.email,
          businessUnit: response.data?.businessUnit,
          token: response.data?.token);
      PersistenceData.shared.saveLoginResponse(loginResponse);
      PersistenceData.shared.saveToken(response.data?.token ?? '');
      return response;
    });
  }

  @override
  Future changePassword(ChangePasswordRequest changePasswordRequest) {
    return tmsDataAgent.changePassword(changePasswordRequest);
  }

  @override
  Future<UserVO> getUser(String token) {
    return tmsDataAgent.getUser(token);
  }

  @override
  Future<List<HouseHoldVO>> getHouseHoldList(String token) {
    return tmsDataAgent.getHouseHoldList(token);
  }
}
