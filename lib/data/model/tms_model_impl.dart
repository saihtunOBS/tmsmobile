import 'dart:io';

import 'package:tmsmobile/data/model/tms_model.dart';
import 'package:tmsmobile/data/vos/announcement_vo.dart';
import 'package:tmsmobile/data/vos/billing_vo.dart';
import 'package:tmsmobile/data/vos/complaint_vo.dart';
import 'package:tmsmobile/data/vos/contract_information_vo.dart';
import 'package:tmsmobile/data/vos/contract_vo.dart';
import 'package:tmsmobile/data/vos/emergency_vo.dart';
import 'package:tmsmobile/data/vos/household_vo.dart';
import 'package:tmsmobile/data/vos/notification_vo.dart';
import 'package:tmsmobile/data/vos/room_shop_vo.dart';
import 'package:tmsmobile/data/vos/service_request_vo.dart';
import 'package:tmsmobile/data/vos/type_of_issue_vo.dart';
import 'package:tmsmobile/network/data_agents/tms_data_agent.dart';
import 'package:tmsmobile/network/requests/change_password_request.dart';
import 'package:tmsmobile/network/requests/household_owner_request.dart';
import 'package:tmsmobile/network/requests/household_request.dart';
import 'package:tmsmobile/network/requests/household_resident_request.dart';
import 'package:tmsmobile/network/requests/login_request.dart';
import 'package:tmsmobile/network/requests/maintenance_status_request.dart';
import 'package:tmsmobile/network/requests/reset_password_request.dart';
import 'package:tmsmobile/network/requests/send_otp_request.dart';
import 'package:tmsmobile/network/requests/verify_otp_request.dart';
import 'package:tmsmobile/network/responses/banner_response.dart';
import 'package:tmsmobile/network/responses/epc_response.dart';
import 'package:tmsmobile/network/responses/fillout_process_response.dart';
import 'package:tmsmobile/network/responses/login_response.dart';
import 'package:tmsmobile/network/responses/maintenance_process_response.dart';
import 'package:tmsmobile/network/responses/otp_response.dart';

import '../../network/data_agents/retrofit_data_agent_impl.dart';
import '../../network/responses/service_request_response.dart';
import '../../network/responses/user_response.dart';

class TmsModelImpl extends TmsModel {
  static final TmsModelImpl _singleton = TmsModelImpl._internal();

  factory TmsModelImpl() {
    return _singleton;
  }

  TmsModelImpl._internal();
  TmsDataAgent tmsDataAgent = RetrofitDataAgentImpl();

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return tmsDataAgent.login(loginRequest);
  }

  @override
  Future<void> logout(String id) {
    return tmsDataAgent.logout(id);
  }

  @override
  Future<void> changePassword(
      String token, ChangePasswordRequest changePasswordRequest) {
    return tmsDataAgent.changePassword(token, changePasswordRequest);
  }

  @override
  Future<UserResponse> getUser(String token) {
    return tmsDataAgent.getUser(token);
  }

  @override
  Future<List<HouseHoldVO>> getHouseHoldList(String token) {
    return tmsDataAgent.getHouseHoldList(token);
  }

  @override
  Future resetPassword(
      String token, ResetPasswordRequest resetPasswordRequest) {
    return tmsDataAgent.resetPassword(token, resetPasswordRequest);
  }

  @override
  Future createComplaint(String token, String complain, List<File> photos) {
    return tmsDataAgent.createComplaint(token, complain, photos);
  }

  @override
  Future<List<ComplaintVO>> getComplaints(String token, status) {
    return tmsDataAgent.getComplaints(token, status);
  }

  @override
  Future<ComplaintVO> getComplaintDetails(String token, String id) {
    return tmsDataAgent.getComplaintDetails(token, id);
  }

  @override
  Future<void> deleteUser(String token) {
    return tmsDataAgent.deleteUser(token);
  }

  @override
  Future<void> createHouseHold(String token, HouseHoldRequest request) {
    return tmsDataAgent.createHouseHold(token, request);
  }

  @override
  Future<void> updateHouseHoldOwner(String token, String houseHoldId,
      String inforId, HouseholdOwnerRequest request) {
    return tmsDataAgent.updateHouseHoldOwner(
        token, houseHoldId, inforId, request);
  }

  @override
  Future<void> updateHouseHoldResident(String token, String houseHoldId,
      String inforId, HouseholdResidentRequest request) {
    return tmsDataAgent.updateHouseHoldResident(
        token, houseHoldId, inforId, request);
  }

  @override
  Future<void> addResident(
      String token, String id, HouseholdResidentRequest request) {
    return tmsDataAgent.addResident(token, id, request);
  }

  @override
  Future<ServiceRequestResponse> createFillOut(String token, List<File> files,
      String tenant, String shop, String description) {
    return tmsDataAgent.createFillOut(token, files, tenant, shop, description);
  }

  @override
  Future<List<ServiceRequestVo>> getFillOuts(
      String token, int page, int limit) {
    return tmsDataAgent.getFillOuts(token, page, 10);
  }

  @override
  Future<void> deleteHouseHold(
      String token, String houseHoldId, String inforId) {
    return tmsDataAgent.deleteHouseHold(token, houseHoldId, inforId);
  }

  @override
  Future<ServiceRequestResponse> createMaintenance(
      String token,
      List<File> files,
      String tenant,
      String shop,
      String description,
      String issue) {
    return tmsDataAgent.createMaintenance(
        token, files, tenant, shop, description, issue);
  }

  @override
  Future<List<ContractVO>> getContracts(String token, int page, int limit) {
    return tmsDataAgent.getContracts(token, page, limit);
  }

  @override
  Future<List<ServiceRequestVo>> getMaintenances(
      String token, int page, int limit) {
    return tmsDataAgent.getMaintenances(token, page, limit);
  }

  @override
  Future<ContractInformationVO> getContractInformation(
      String token, String id) {
    return tmsDataAgent.getContractInformation(token, id);
  }

  @override
  Future<List<AnnouncementVO>> getAnnouncements(String token) {
    return tmsDataAgent.getAnnouncements(token);
  }

  @override
  Future<List<EmergencyVO>> getEmergency(String token, int page, int limit) {
    return tmsDataAgent.getEmergency(token, page, limit);
  }

  @override
  Future<List<PropertyInformation>> getParking(
      String token, int page, int limit) {
    return tmsDataAgent.getParking(token, page, limit);
  }

  @override
  Future<AnnouncementVO> getAnnouncementDetail(String token, String id) {
    return tmsDataAgent.getAnnouncementDetail(token, id);
  }

  @override
  Future<LoginResponse> sendOTP(SendOtpRequest request) {
    return tmsDataAgent.sendOTP(request);
  }

  @override
  Future<OTPResponse> verifyOTP(String token, VerifyOtpRequest request) {
    return tmsDataAgent.verifyOTP(token, request);
  }

  @override
  Future<void> updateProfile(String token, File photo) {
    return tmsDataAgent.updateProfile(token, photo);
  }

  @override
  Future<List<TypeOfIssueVO>> getTypeOfIssues(String token) {
    return tmsDataAgent.getTypeOfIssues(token);
  }

  @override
  Future<List<RoomShopVO>> getProperties(String token) {
    return tmsDataAgent.getProperties(token);
  }

  @override
  Future<MaintenanceProcessResponse> getMaintenanceProcess(
      String token, String id) {
    return tmsDataAgent.getMaintenanceProcess(token, id);
  }

  @override
  Future<void> changeMaintenanceStatus(
      String token, String id, MaintenanceStatusRequest request) {
    return tmsDataAgent.changeMaintenanceStatus(token, id, request);
  }

  @override
  Future<List<BillingVO>> getBillingLists(String token) {
    return tmsDataAgent.getBillingLists(token);
  }

  @override
  Future<FilloutProcessResponse> getFilloutProcess(String token, String id) {
    return tmsDataAgent.getFilloutProcess(token, id);
  }

  @override
  Future<BannerResponse> getBannerLists(String token) {
    return tmsDataAgent.getBannerLists(token);
  }

  @override
  Future<EpcResponse> getEpcResponse(String token) {
    return tmsDataAgent.getEpcResponse(token);
  }

  @override
  Future<List<NotificationVO>> getNotifications(String token) {
    return tmsDataAgent.getNotifications(token);
  }
}
