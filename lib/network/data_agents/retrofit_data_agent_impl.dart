import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tmsmobile/data/persistance_data/persistence_data.dart';
import 'package:tmsmobile/data/vos/announcement_vo.dart';
import 'package:tmsmobile/data/vos/billing_vo.dart';
import 'package:tmsmobile/data/vos/complaint_vo.dart';
import 'package:tmsmobile/data/vos/contract_information_vo.dart';
import 'package:tmsmobile/data/vos/contract_vo.dart';
import 'package:tmsmobile/data/vos/emergency_vo.dart';
import 'package:tmsmobile/data/vos/household_vo.dart';
import 'package:tmsmobile/data/vos/room_shop_vo.dart';
import 'package:tmsmobile/data/vos/service_request_vo.dart';
import 'package:tmsmobile/data/vos/type_of_issue_vo.dart';
import 'package:tmsmobile/data/vos/user_vo.dart';
import 'package:tmsmobile/network/data_agents/tms_data_agent.dart';
import 'package:tmsmobile/network/requests/change_password_request.dart';
import 'package:tmsmobile/network/requests/complaint_request.dart';
import 'package:tmsmobile/network/requests/household_owner_request.dart';
import 'package:tmsmobile/network/requests/household_request.dart';
import 'package:tmsmobile/network/requests/login_request.dart';
import 'package:tmsmobile/network/requests/maintenance_status_request.dart';
import 'package:tmsmobile/network/requests/reset_password_request.dart';
import 'package:tmsmobile/network/requests/send_otp_request.dart';
import 'package:tmsmobile/network/requests/verify_otp_request.dart';
import 'package:tmsmobile/network/responses/banner_response.dart';
import 'package:tmsmobile/network/responses/fillout_process_response.dart';
import 'package:tmsmobile/network/responses/login_response.dart';
import 'package:tmsmobile/network/responses/otp_response.dart';
import 'package:tmsmobile/network/tms_api.dart';

import '../../data/vos/error_vo.dart';
import '../../exception/custom_exception.dart';
import '../requests/household_resident_request.dart';
import '../responses/maintenance_process_response.dart';
import '../responses/service_request_response.dart';
import '../responses/user_response.dart';

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
  Future changePassword(
      String token, ChangePasswordRequest changePasswordRequest) {
    return tmsApi
        .changePassword('Bearer $token', changePasswordRequest)
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
  Future<List<ComplaintVO>> getComplaints(String token,int status) {
    return tmsApi
        .getComplaint('Bearer $token',status)
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
  Future<UserResponse> getUser(String token) {
    return tmsApi
        .getUser('Bearer $token')
        .asStream()
        .map((response) {
          var userVo = UserVO(
              tenantName: response.data?.tenantName,
              photo: response.data?.photo,phoneNumber: response.data?.phoneNumber);
          PersistenceData.shared.saveUserData(userVo);
          return response;
        })
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
  Future<void> createHouseHold(String token, HouseHoldRequest request) {
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
  Future<void> updateHouseHoldOwner(String token, String houseHoldId,
      String inforId, HouseholdOwnerRequest request) {
    return tmsApi
        .updateHouseHoldOwner('Bearer $token', houseHoldId, inforId, request)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<void> updateHouseHoldResident(String token, String houseHoldId,
      String inforId, HouseholdResidentRequest request) {
    return tmsApi
        .updateHouseHoldResident('Bearer $token', houseHoldId, inforId, request)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<void> addResident(
      String token, String id, HouseholdResidentRequest request) {
    return tmsApi
        .addResident('Bearer $token', id, request)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<ServiceRequestVo>> getFillOuts(
      String token, int page, int limit) {
    return tmsApi
        .getFilOut('Bearer $token', page, limit)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<ServiceRequestResponse> createFillOut(String token, List<File> files,
      String tenant, String shop, String description) {
    return tmsApi
        .createFillOut('Bearer $token', files, tenant, shop, description)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<ServiceRequestResponse> createMaintenance(
      String token,
      List<File> files,
      String tenant,
      String shop,
      String description,
      String issue) {
    return tmsApi
        .createMaintenance(
            'Bearer $token', files, tenant, shop, issue, description)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<void> deleteHouseHold(
      String token, String houseHoldId, String inforId) {
    return tmsApi
        .deleteHouseHold('Bearer $token', houseHoldId, inforId)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<ContractVO>> getContracts(String token, int page, int limit) {
    return tmsApi
        .getContracts('Bearer $token', page, 10)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<ServiceRequestVo>> getMaintenances(
      String token, int page, int limit) {
    return tmsApi
        .getMaintenance('Bearer $token', page, 10)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<ContractInformationVO> getContractInformation(
      String token, String id) {
    return tmsApi
        .getContractInformation('Bearer $token', id)
        .asStream()
        .map((response) => response.data as ContractInformationVO)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<AnnouncementVO>> getAnnouncements(String token) {
    return tmsApi
        .getAnnouncements('Bearer $token')
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<EmergencyVO>> getEmergency(String token, int page, int limit) {
    return tmsApi
        .getEmergency('Bearer $token', page, limit)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<PropertyInformation>> getParking(
      String token, int page, int limit) {
    return tmsApi
        .getParking('Bearer $token', page, limit)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<AnnouncementVO> getAnnouncementDetail(String token, String id) {
    return tmsApi
        .getAnnouncementDetail('Bearer $token', id)
        .asStream()
        .map((response) => response.data as AnnouncementVO)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<LoginResponse> sendOTP(SendOtpRequest request) {
    return tmsApi
        .sendOTP(request)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<OTPResponse> verifyOTP(String token, VerifyOtpRequest request) {
    return tmsApi
        .verifyOTP('Bearer $token', request)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<void> updateProfile(String token, File photo) {
    return tmsApi
        .updateProfile('Bearer $token', photo)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<TypeOfIssueVO>> getTypeOfIssues(String token) {
    return tmsApi
        .getTypeOfIssues('Bearer $token')
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<RoomShopVO>> getProperties(String token) {
    return tmsApi
        .getProperties('Bearer $token')
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<MaintenanceProcessResponse> getMaintenanceProcess(
      String token, String id) {
    return tmsApi
        .getMaintenanceProcess('Bearer $token', id)
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
  Future<void> changeMaintenanceStatus(
      String token, String id, MaintenanceStatusRequest request) {
    return tmsApi
        .changeMaintenanceStatus('Bearer $token', request, id)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<BillingVO>> getBillingLists(String token) {
    return tmsApi
        .getBiling('Bearer $token')
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<FilloutProcessResponse> getFilloutProcess(String token, String id) {
    return tmsApi
        .getFilloutProcess('Bearer $token', id)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<BannerResponse> getBannerLists(String token) {
    return tmsApi
        .getBanner('Bearer $token')
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
