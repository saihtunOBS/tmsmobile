import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tmsmobile/data/vos/complaint_vo.dart';
import 'package:tmsmobile/data/vos/household_vo.dart';
import 'package:tmsmobile/data/vos/user_vo.dart';
import 'package:tmsmobile/network/data_agents/tms_data_agent.dart';
import 'package:tmsmobile/network/requests/change_password_request.dart';
import 'package:tmsmobile/network/requests/complaint_request.dart';
import 'package:tmsmobile/network/requests/household_owner_request.dart';
import 'package:tmsmobile/network/requests/household_registration_request.dart';
import 'package:tmsmobile/network/requests/login_request.dart';
import 'package:tmsmobile/network/requests/reset_password_request.dart';
import 'package:tmsmobile/network/responses/login_response.dart';
import 'package:tmsmobile/network/tms_api.dart';

import '../../data/vos/error_vo.dart';
import '../../exception/custom_exception.dart';
import '../requests/household_resident_request.dart';

class RetrofitDataAgentImpl extends TmsDataAgent {
  late TmsApi tmsApi;
  static RetrofitDataAgentImpl? _singleton;

  ///singleton
  factory RetrofitDataAgentImpl() {
    _singleton ??= RetrofitDataAgentImpl._internal();
    return _singleton!;
  }

  ///private constructor
  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    tmsApi = TmsApi(dio);
  }

  ///login
  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return tmsApi
        .login(loginRequest)
        .asStream()
        .map((response) {
          return response;
        })
        .first
        .catchError((error) {
          throw _createException(error);
        });
  }

  @override
  Future changePassword(ChangePasswordRequest changePasswordRequest) {
    return tmsApi
        .changePassword(changePasswordRequest)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future resetPassword(
      String token, ResetPasswordRequest resetPasswordRequest) {
    return tmsApi
        .resetPassword('Bearer $token', resetPasswordRequest)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future createComplaint(String token, ComplaintRequest request) {
    return tmsApi
        .createComplaint('Bearer $token', request)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<ComplaintVO>> getComplaints(String token) {
    return tmsApi
        .getComplaint('Bearer $token')
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<ComplaintVO> getComplaintDetails(String token, String id) {
    return tmsApi
        .getComplaintDetail('Bearer $token', id)
        .asStream()
        .map((response) => response.data as ComplaintVO)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<UserVO> getUser(String token) {
    return tmsApi
        .getUser('Bearer $token')
        .asStream()
        .map((response) => response.data ?? UserVO())
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<HouseHoldVO>> getHouseHoldList(String token) {
    return tmsApi
        .getHouseHoldList('Bearer $token')
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<void> deleteUser(String token) {
    return tmsApi
        .deleteUser('Bearer $token')
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<void> createHouseHold(
      String token, HouseholdRegistrationRequest request) {
    return tmsApi
        .createHouseHold('Bearer $token', request)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<void> updateHouseHoldOwner(
      String token, String id, HouseholdOwnerRequest request) {
    return tmsApi
        .updateHouseHoldOwner('Bearer $token', id, request)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<void> updateHouseHoldResident(
      String token, String id, HouseholdResidentRequest request) {
    return tmsApi
        .updateHouseHoldResident('Bearer $token', id, request)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }
}

///custom exception
CustomException _createException(dynamic error) {
  ErrorVO errorVO;
  if (error is DioException) {
    errorVO = _parseDioError(error);
  } else {
    errorVO = ErrorVO(
      status: false,
      message: "UnExcepted error",
    );
  }
  return CustomException(errorVO);
}

ErrorVO _parseDioError(DioException error) {
  try {
    if (error.response != null || error.response?.data != null) {
      var data = error.response?.data;

      ///Json string to Map<String,dynamic>
      if (data is String) {
        data = jsonDecode(data);
      }

      ///Map<String,dynamic> to ErrorVO
      return ErrorVO.fromJson(data);
    } else {
      return ErrorVO(status: false, message: "No response data");
    }
  } catch (e) {
    return ErrorVO(status: false, message: "Invalid DioException Format");
  }
}
