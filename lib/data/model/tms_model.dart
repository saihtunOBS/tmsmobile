import 'package:tmsmobile/data/vos/user_vo.dart';
import 'package:tmsmobile/network/responses/login_response.dart';

import '../../network/requests/change_password_request.dart';
import '../../network/requests/complaint_request.dart';
import '../../network/requests/household_owner_request.dart';
import '../../network/requests/household_registration_request.dart';
import '../../network/requests/household_resident_request.dart';
import '../../network/requests/login_request.dart';
import '../../network/requests/reset_password_request.dart';
import '../vos/complaint_vo.dart';
import '../vos/household_vo.dart';

abstract class TmsModel {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future changePassword(ChangePasswordRequest changePasswordRequest);
  Future<void> deleteUser(String token);
  Future<UserVO> getUser(String token);
  Future<List<HouseHoldVO>> getHouseHoldList(String token);
  Future<void> createHouseHold(
      String token, HouseholdRegistrationRequest request);
  Future<void> updateHouseHoldOwner(String token,String id,HouseholdOwnerRequest request);
  Future<void> updateHouseHoldResident(String token,String id,HouseholdResidentRequest request);
  Future resetPassword(String token, ResetPasswordRequest resetPasswordRequest);
  Future createComplaint(String token, ComplaintRequest request);
  Future<List<ComplaintVO>> getComplaints(String token);
  Future<ComplaintVO> getComplaintDetails(String token, String id);
}
