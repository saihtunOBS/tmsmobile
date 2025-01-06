import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmsmobile/network/api_constants.dart';
import 'package:tmsmobile/network/responses/household_response.dart';

import 'requests/change_password_request.dart';
import 'requests/login_request.dart';
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


  @GET(kEndPointUserProfile)
  Future<UserResponse> getUser(
    @Header(kHeaderAuthorization) String token,
  );

  @GET(kEndPointHouseHoldList)
  Future<HouseholdResponse> getHouseHoldList(
    @Header(kHeaderAuthorization) String token,
  );
}
