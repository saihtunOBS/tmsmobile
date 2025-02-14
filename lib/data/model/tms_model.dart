import 'dart:io';
import 'package:tmsmobile/network/requests/household_request.dart';
import 'package:tmsmobile/network/responses/login_response.dart';
import 'package:tmsmobile/network/responses/user_response.dart';

import '../../network/requests/change_password_request.dart';
import '../../network/requests/household_owner_request.dart';
import '../../network/requests/household_resident_request.dart';
import '../../network/requests/login_request.dart';
import '../../network/requests/maintenance_status_request.dart';
import '../../network/requests/reset_password_request.dart';
import '../../network/requests/send_otp_request.dart';
import '../../network/requests/verify_otp_request.dart';
import '../../network/responses/banner_response.dart';
import '../../network/responses/fillout_process_response.dart';
import '../../network/responses/maintenance_process_response.dart';
import '../../network/responses/otp_response.dart';
import '../../network/responses/service_request_response.dart';
import '../vos/announcement_vo.dart';
import '../vos/billing_vo.dart';
import '../vos/complaint_vo.dart';
import '../vos/contract_information_vo.dart';
import '../vos/contract_vo.dart';
import '../vos/emergency_vo.dart';
import '../vos/household_vo.dart';
import '../vos/room_shop_vo.dart';
import '../vos/service_request_vo.dart';
import '../vos/type_of_issue_vo.dart';

abstract class TmsModel {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<void> changePassword(
      String token, ChangePasswordRequest changePasswordRequest);
  Future<void> deleteUser(String token);
  Future<UserResponse> getUser(String token);
  Future<List<HouseHoldVO>> getHouseHoldList(String token);
  Future<void> addResident(
      String token, String id, HouseholdResidentRequest request);
  Future<void> createHouseHold(String token, HouseHoldRequest request);
  Future<void> updateHouseHoldOwner(String token, String houseHoldId,
      String inforId, HouseholdOwnerRequest request);
  Future<void> updateHouseHoldResident(String token, String houseHoldId,
      String inforId, HouseholdResidentRequest request);
  Future<void> deleteHouseHold(
      String token, String houseHoldId, String inforId);
  Future resetPassword(String token, ResetPasswordRequest resetPasswordRequest);
  Future createComplaint(String token, String complain, List<File> photos);
  Future<List<ComplaintVO>> getComplaints(String token,int status);
  Future<ComplaintVO> getComplaintDetails(String token, String id);
  Future<List<ServiceRequestVo>> getFillOuts(String token, int page, int limit);
  Future<ServiceRequestResponse> createFillOut(String token, List<File> files,
      String tenant, String shop, String description);
  Future<ServiceRequestResponse> createMaintenance(
      String token,
      List<File> files,
      String tenant,
      String shop,
      String description,
      String issue);
  Future<List<ServiceRequestVo>> getMaintenances(String token,int page, int limit);
  Future<List<ContractVO>> getContracts(String token, int page, int limit);
  Future<ContractInformationVO> getContractInformation(String token, String id);
  Future<List<AnnouncementVO>> getAnnouncements(String token);
  Future<List<PropertyInformation>> getParking(
      String token, int page, int limit);
  Future<List<EmergencyVO>> getEmergency(String token, int page, int limit);
  Future<AnnouncementVO> getAnnouncementDetail(String token, String id);
  Future<LoginResponse> sendOTP(SendOtpRequest request);
  Future<OTPResponse> verifyOTP(String token, VerifyOtpRequest request);
  Future<void> updateProfile(String token, File photo);
  Future<List<TypeOfIssueVO>> getTypeOfIssues(String token);
  Future<List<RoomShopVO>> getProperties(String token);
  Future<MaintenanceProcessResponse> getMaintenanceProcess(String token,String id);
  Future<FilloutProcessResponse> getFilloutProcess(String token,String id);
  Future<void> changeMaintenanceStatus(String token,String id,MaintenanceStatusRequest request);
  Future<List<BillingVO>> getBillingLists(String token);
  Future<BannerResponse> getBannerLists(String token);
}
