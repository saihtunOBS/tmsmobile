import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmsmobile/network/api_constants.dart';
import 'package:tmsmobile/network/requests/complaint_request.dart';
import 'package:tmsmobile/network/requests/reset_password_request.dart';
import 'package:tmsmobile/network/responses/complaint_response.dart';
import 'package:tmsmobile/network/responses/household_response.dart';

import 'requests/change_password_request.dart';
import 'requests/login_request.dart';
import 'responses/complaint_detail_response.dart';
import 'responses/login_response.dart';
import 'responses/user_response.dart';

part 'tms_api.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class TmsApi {
  factory TmsApi(Dio dio) = _TmsApi;

  @POST(kEndPointLogin)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @POST(kEndPointChangePassword)
  Future<LoginResponse> changePassword(@Body() ChangePasswordRequest changePasswordRequest);

  @POST(kEndPointResetPassword)
  Future resetPassword(
    @Header(kHeaderAuthorization) String token,
    @Body() ResetPasswordRequest resetPasswordRequest);

  @DELETE(kEndPointDeleteUser)
  Future<void> deleteUser(
    @Header(kHeaderAuthorization) String token,
  );

  @POST(kEndPointComplaintCreate)
  Future createComplaint(
    @Header(kHeaderAuthorization) String token,
    @Body() ComplaintRequest request);

  @GET(kEndPointComplaint)
  Future<ComplaintResponse> getComplaint(
    @Header(kHeaderAuthorization) String token,
  );

  @GET('$kEndPointComplaintDetail/{id}')
  Future<ComplaintDetailResponse> getComplaintDetail(
    @Header(kHeaderAuthorization) String token,
    @Path('id') String complaintId
  );

  @GET(kEndPointUserProfile)
  Future<UserResponse> getUser(
    @Header(kHeaderAuthorization) String token,
  );


  @GET(kEndPointHouseHoldList)
  Future<HouseholdResponse> getHouseHoldList(
    @Header(kHeaderAuthorization) String token,
  );
}
