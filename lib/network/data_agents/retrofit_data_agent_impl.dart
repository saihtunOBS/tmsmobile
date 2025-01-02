import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tmsmobile/network/data_agents/tms_data_agent.dart';
import 'package:tmsmobile/network/tms_api.dart';

import '../../data/vos/error_vo.dart';
import '../../exception/custom_exception.dart';

class RetrofitDataAgentImpl extends TmsDataAgent {
  late TmsApi tmsApi;
  static RetrofitDataAgentImpl? _singleton;

  ///singleton
  factory RetrofitDataAgentImpl() {
    _singleton ??= RetrofitDataAgentImpl._singleton;
    return _singleton!;
  }

  ///private constructor
  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    tmsApi = TmsApi(dio);
  }

  ///custom exception
  CustomException _createException(dynamic error) {
    ErrorVO errorVO;
    if (error is DioException) {
      errorVO = _parseDioError(error);
    } else {
      errorVO = ErrorVO(
        statusCode: 0,
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
        return ErrorVO(statusCode: 0, message: "No response data");
      }
    } catch (e) {
      return ErrorVO(statusCode: 0, message: "Invalid DioException Format");
    }
  }
}
