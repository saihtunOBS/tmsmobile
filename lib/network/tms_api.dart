import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmsmobile/network/api_constants.dart';
import 'package:tmsmobile/network/requests/household_request.dart';
import 'package:tmsmobile/network/requests/maintenance_status_request.dart';
import 'package:tmsmobile/network/requests/reset_password_request.dart';
import 'package:tmsmobile/network/requests/send_otp_request.dart';
import 'package:tmsmobile/network/responses/announcement_detail_response.dart';
import 'package:tmsmobile/network/responses/announcement_response.dart';
import 'package:tmsmobile/network/responses/billing_response.dart';
import 'package:tmsmobile/network/responses/complaint_response.dart';
import 'package:tmsmobile/network/responses/contract_response.dart';
import 'package:tmsmobile/network/responses/emergency_response.dart';
import 'package:tmsmobile/network/responses/epc_response.dart';
import 'package:tmsmobile/network/responses/household_response.dart';
import 'package:tmsmobile/network/responses/maintenance_process_response.dart';
import 'package:tmsmobile/network/responses/notification_response.dart';
import 'package:tmsmobile/network/responses/otp_response.dart';
import 'package:tmsmobile/network/responses/service_request_response.dart';

import 'requests/change_password_request.dart';
import 'requests/household_owner_request.dart';
import 'requests/household_resident_request.dart';
import 'requests/login_request.dart';
import 'requests/verify_otp_request.dart';
import 'responses/banner_response.dart';
import 'responses/complaint_detail_response.dart';
import 'responses/contract_information_response.dart';
import 'responses/fillout_process_response.dart';
import 'responses/login_response.dart';
import 'responses/parking_response.dart';
import 'responses/property_response.dart';
import 'responses/type_of_issue_response.dart';
import 'responses/user_response.dart';

part 'tms_api.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class TmsApi {
  factory TmsApi(Dio dio) = _TmsApi;

  @POST(kEndPointLogin)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @PATCH('$kEndPointLogout/{id}')
  Future<void> logout(@Path('id') id);

  @POST(kEndPointSendOtp)
  Future<LoginResponse> sendOTP(@Body() SendOtpRequest request);

  @POST(kEndPointVerifyOtp)
  Future<OTPResponse> verifyOTP(@Header(kHeaderAuthorization) String token,
      @Body() VerifyOtpRequest request);

  @POST(kEndPointChangePassword)
  Future<void> changePassword(@Header(kHeaderAuthorization) String token,
      @Body() ChangePasswordRequest changePasswordRequest);

  @POST(kEndPointResetPassword)
  Future<void> resetPassword(@Header(kHeaderAuthorization) String token,
      @Body() ResetPasswordRequest resetPasswordRequest);

  @DELETE(kEndPointDeleteUser)
  Future<void> deleteUser(
    @Header(kHeaderAuthorization) String token,
  );

  @MultiPart()
  @POST(kEndPointComplaintCreate)
  Future createComplaint(@Header(kHeaderAuthorization) String token,
      @Part() String complaint, @Part() List<File> photos);

  @GET(kEndPointComplaint)
  Future<ComplaintResponse> getComplaint(
      @Header(kHeaderAuthorization) String token, @Query('status') int id);

  @GET('$kEndPointComplaintDetail/{id}')
  Future<ComplaintDetailResponse> getComplaintDetail(
      @Header(kHeaderAuthorization) String token,
      @Path('id') String complaintId);

  @GET(kEndPointUserProfile)
  Future<UserResponse> getUser(
    @Header(kHeaderAuthorization) String token,
  );

  @GET(kEndPointHouseHoldList)
  Future<HouseholdResponse> getHouseHoldList(
    @Header(kHeaderAuthorization) String token,
  );

  @POST(kEndPointHouseHoldCreate)
  Future<void> createHouseHold(@Header(kHeaderAuthorization) String token,
      @Body() HouseHoldRequest request);

  @PATCH('$kEndPointHouseHoldUpdate/{house_hold_id}/{inforId}')
  Future<void> updateHouseHoldOwner(
      @Header(kHeaderAuthorization) String token,
      @Path() String house_hold_id,
      @Path() String inforId,
      @Body() HouseholdOwnerRequest request);

  @PATCH('$kEndPointHouseHoldUpdate/{house_hold_id}/{inforId}')
  Future<void> updateHouseHoldResident(
      @Header(kHeaderAuthorization) String token,
      @Path() String house_hold_id,
      @Path() String inforId,
      @Body() HouseholdResidentRequest request);

  @DELETE('$kEndPointHouseHoldDelete/{house_hold_id}/{inforId}')
  Future<void> deleteHouseHold(
    @Header(kHeaderAuthorization) String token,
    @Path() String house_hold_id,
    @Path() String inforId,
  );

  @POST('$kEndPointAddResident/{id}')
  Future<void> addResident(@Header(kHeaderAuthorization) String token,
      @Path() String id, @Body() HouseholdResidentRequest request);

  @GET(kEndPointFilOutRequest)
  Future<ServiceRequestResponse> getFilOut(
    @Header(kHeaderAuthorization) String token,
    @Query("page") int page,
    @Query("limit") int limit,
  );

  @GET(kEndPointMaintenanceRequest)
  Future<ServiceRequestResponse> getMaintenance(
    @Header(kHeaderAuthorization) String token,
    @Query("page") int page,
    @Query("limit") int limit,
  );

  @MultiPart()
  @POST(kEndPointCreateFillOut)
  Future<ServiceRequestResponse> createFillOut(
      @Header(kHeaderAuthorization) String token,
      @Part() List<File> photo,
      @Part() String tenant,
      @Part() String shop,
      @Part() String description);

  @MultiPart()
  @POST(kEndPointCreateMaintenance)
  Future<ServiceRequestResponse> createMaintenance(
      @Header(kHeaderAuthorization) String token,
      @Part() List<File> attach,
      @Part() String tenant,
      @Part() String shop,
      @Part() String issue,
      @Part() String description);

  @MultiPart()
  @PATCH(kEndPointUpdateProfile)
  Future<void> updateProfile(
    @Header(kHeaderAuthorization) String token,
    @Part() File photo,
  );

  @GET(kEndPointContract)
  Future<ContractResponse> getContracts(
    @Header(kHeaderAuthorization) String token,
    @Query("page") int page,
    @Query("limit") int limit,
  );

  @GET('$kEndPointContractInformation/{id}')
  Future<ContractInformationResponse> getContractInformation(
      @Header(kHeaderAuthorization) String token, @Path() String id);

  @GET(kEndPointAnnouncement)
  Future<AnnouncementResponse> getAnnouncements(
    @Header(kHeaderAuthorization) String token,
  );

  @GET(kEndPointParking)
  Future<ParkingResponse> getParking(
    @Header(kHeaderAuthorization) String token,
    @Query("page") int page,
    @Query("limit") int limit,
  );

  @GET('$kEndPointAnnouncementDetail/{id}')
  Future<AnnouncementDetailResponse> getAnnouncementDetail(
      @Header(kHeaderAuthorization) String token, @Path() String id);

  @GET(kEndPointTypeOfIssues)
  Future<TypeOfIssueResponse> getTypeOfIssues(
      @Header(kHeaderAuthorization) String token);

  @GET(kEndPointEmergency)
  Future<EmergencyResponse> getEmergency(
    @Header(kHeaderAuthorization) String token,
    @Query("page") int page,
    @Query("limit") int limit,
  );

  @GET(kEndPointProperty)
  Future<PropertyResponse> getProperties(
    @Header(kHeaderAuthorization) String token,
  );

  @GET('$kEndPointMaintenanceProcess/{id}')
  Future<MaintenanceProcessResponse> getMaintenanceProcess(
      @Header(kHeaderAuthorization) String token, @Path() String id);

  @GET('$kEndPointFilOutProcess/{id}')
  Future<FilloutProcessResponse> getFilloutProcess(
      @Header(kHeaderAuthorization) String token, @Path() String id);

  @PATCH('$kChangeMaintenanceStatus/{id}')
  Future<void> changeMaintenanceStatus(
      @Header(kHeaderAuthorization) String token,
      @Body() MaintenanceStatusRequest request,
      @Path() String id);

  @GET(kEndPointBilling)
  Future<BillingResponse> getBiling(@Header(kHeaderAuthorization) String token);

  @GET(kEndPointBanner)
  Future<BannerResponse> getBanner(@Header(kHeaderAuthorization) String token);

  @GET(kEndPointEpc)
  Future<EpcResponse> getEpcResponse(
      @Header(kHeaderAuthorization) String token);

  @GET(kEndPointNotification)
  Future<NotificationResponse> getNotifications(
      @Header(kHeaderAuthorization) String token);
}
