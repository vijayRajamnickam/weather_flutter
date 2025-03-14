import 'dart:convert';

import 'package:dio/dio.dart';

import '../utils/either.dart';
import 'error.dart';

extension NetworkInterceptor on Response<dynamic> {
  Future<Either<Failure, String>> getResult() async {
    var result = Either<Failure, String>();
    if (statusCode == 200 || statusCode == 201 || statusCode == 204) {
      if (data == null) {
        result.setLeft(ApiReturnNull(data));
      } else {
        result.setRight(json.encode(data));
      }
    } else {
      print('dio error response $statusCode $statusMessage');
      result.setLeft(CustomError(statusMessage));
    }
    return result;
  }
}

extension ErrorCodeHandler on String? {
  Failure getFailureType({String? statusMessage}) {
    Failure result = UnknownError('');

    if ((this ?? "").contains(BadRequest(statusMessage).errorCode.toString())) {
      result = BadRequest(statusMessage);
    } else if ((this ?? "")
        .contains(Forbidden(statusMessage).errorCode.toString())) {
      result = Forbidden(statusMessage);
    } else if ((this ?? "")
        .contains(InvalidToken(statusMessage).errorCode.toString())) {
      result = InvalidToken(statusMessage);
    } else if ((this ?? "")
        .contains(NoData(statusMessage).errorCode.toString())) {
      result = NoData(statusMessage);
    } else if ((this ?? "")
        .contains(UrlNotFound(statusMessage).errorCode.toString())) {
      result = UrlNotFound(statusMessage);
    } else if ((this ?? "")
        .contains(MethodNotAllowed(statusMessage).errorCode.toString())) {
      result = MethodNotAllowed(statusMessage);
    } else if ((this ?? "")
        .contains(InternalServerError(statusMessage).errorCode.toString())) {
      result = InternalServerError(statusMessage);
    } else if ((this ?? "")
        .contains(BadGateway(statusMessage).errorCode.toString())) {
      result = BadGateway(statusMessage);
    } else if ((this ?? "")
        .contains(ServerUnavailable(statusMessage).errorCode.toString())) {
      result = ServerUnavailable(statusMessage);
    } else if ((this ?? "")
        .contains(GatewayTimeout(statusMessage).errorCode.toString())) {
      result = GatewayTimeout(statusMessage);
    } else if ((this ?? "").contains('SocketException')) {
      result = NoInternetConnection(statusMessage);
    } else {
      result = UnknownError(statusMessage);
    }
    return result;
  }
}

extension DioErrorHandling on DioException {
  Failure getDioError() {
    Failure result = UnknownError('');
    result = message.getFailureType(
        statusMessage: response?.data.toString() ?? "Error Occurred");
    return result;
  }
}
