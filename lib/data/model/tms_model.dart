import 'dart:io';
import 'package:tmsmobile/data/vos/user_vo.dart';
import 'package:tmsmobile/network/responses/login_response.dart';

import '../../network/requests/change_password_request.dart';
import '../../network/requests/complaint_request.dart';
import '../../network/requests/household_owner_request.dart';
import '../../network/requests/household_registration_request.dart';
import '../../network/requests/household_resident_request.dart';
import '../../network/requests/login_request.dart';
import '../../network/requests/reset_password_request.dart';
import '../../network/responses/service_request_response.dart';
import '../vos/announcement_vo.dart';
import '../vos/complaint_vo.dart';
import '../vos/contract_information_vo.dart';
import '../vos/contract_vo.dart';
import '../vos/emergency_vo.dart';
import '../vos/household_vo.dart';
import '../vos/service_request_vo.dart';

abstract class TmsModel {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<void> changePassword(String token,ChangePasswordRequest changePasswordRequest);
  Future<void> deleteUser(String token);
  Future<UserVO> getUser(String token);
  Future<List<HouseHoldVO>> getHouseHoldList(String token);
  Future<void> addResident(
      String token, String id, HouseholdResidentRequest request);
  Future<void> createHouseHold(
      String token, HouseholdRegistrationRequest request);
  Future<void> updateHouseHoldOwner(String token, String houseHoldId,
      String inforId, HouseholdOwnerRequest request);
  Future<void> updateHouseHoldResident(String token, String houseHoldId,
      String inforId, HouseholdResidentRequest request);
  Future<void> deleteHouseHold(String token, String houseHoldId,
      String inforId);
  Future resetPassword(String token, ResetPasswordRequest resetPasswordRequest);
  Future createComplaint(String token, ComplaintRequest request);
  Future<List<ComplaintVO>> getComplaints(String token);
  Future<ComplaintVO> getComplaintDetails(String token, String id);
  Future<List<ServiceRequestVo>> getFillOuts(String token, int page, int limit);
  Future<ServiceRequestResponse> createFillOut(String token, List<File> files,
      String tenant, String shop, String description);
  Future<ServiceRequestResponse> createMaintenance(String token, List<File> files,
      String tenant, String shop, String description,String issue);
  Future<List<ServiceRequestVo>> getMaintenances(String token);
  Future<List<ContractVO>> getContracts(String token, int page, int limit);
  Future<ContractInformationVO> getContractInformation(String token, String id);
  Future<List<AnnouncementVO>> getAnnouncements(String token);
  Future<List<ContractInformationVO>> getParking(String token,int page, int limit);
  Future<List<EmergencyVO>> getEmergency(String token,int page, int limit);
}
