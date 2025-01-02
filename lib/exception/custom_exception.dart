import '../data/vos/error_vo.dart';

class CustomException implements Exception {
  final ErrorVO errorVO;

  CustomException(this.errorVO);

  @override
  String toString() => errorVO.getErrorMessages() ?? "";
}
