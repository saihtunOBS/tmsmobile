import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tmsmobile/data/vos/household_vo.dart';
import 'package:tmsmobile/data/vos/user_vo.dart';
import 'package:tmsmobile/network/data_agents/tms_data_agent.dart';
import 'package:tmsmobile/network/requests/change_password_request.dart';
import 'package:tmsmobile/network/requests/login_request.dart';
import 'package:tmsmobile/network/responses/login_response.dart';
import 'package:tmsmobile/network/tms_api.dart';

import '../../data/vos/error_vo.dart';
import '../../exception/custom_exception.dart';

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
}
