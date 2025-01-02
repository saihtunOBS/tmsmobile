
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmsmobile/network/api_constants.dart';

part 'tms_api.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class TmsApi {
  factory TmsApi(Dio dio) = _TmsApi;
}