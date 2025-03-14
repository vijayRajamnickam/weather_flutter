import 'package:equatable/equatable.dart';

///abstract class for Failure
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [error, errorCode, errorMessage];

  String get error;

  int get errorCode;

  String get errorMessage;
}

///400
class BadRequest extends Failure {
  final String? statusMessage;

  BadRequest(this.statusMessage);

  @override
  String get error => "BAD REQUEST";

  @override
  int get errorCode => 400;

  @override
  String get errorMessage => statusMessage ?? '';
}

///204
class NoData extends Failure {
  final String? statusMessage;

  NoData(this.statusMessage);

  @override
  String get error => "NO DATA";

  @override
  int get errorCode => 204;

  @override
  String get errorMessage => statusMessage ?? '';
}

///403
class Forbidden extends Failure {
  final String? statusMessage;

  Forbidden(this.statusMessage);

  @override
  String get error => "FORBIDDEN";

  @override
  int get errorCode => 403;

  @override
  String get errorMessage => statusMessage ?? '';
}

///403
class InvalidToken extends Failure {
  final String? statusMessage;

  InvalidToken(this.statusMessage);

  @override
  String get error => "INVALID TOKEN";

  @override
  int get errorCode => 401;

  @override
  String get errorMessage => statusMessage ?? '';
}

///404
class UrlNotFound extends Failure {
  final String? statusMessage;

  UrlNotFound(this.statusMessage);

  @override
  String get error => "NOT FOUND";

  @override
  int get errorCode => 404;

  @override
  String get errorMessage => statusMessage ?? '';
}

///405
class MethodNotAllowed extends Failure {
  final String? statusMessage;

  MethodNotAllowed(this.statusMessage);

  @override
  String get error => "METHOD NOT ALLOWED";

  @override
  int get errorCode => 405;

  @override
  String get errorMessage => statusMessage ?? '';
}

///500
class InternalServerError extends Failure {
  final String? statusMessage;

  InternalServerError(this.statusMessage);

  @override
  String get error => "SERVER ERROR";

  @override
  int get errorCode => 500;

  @override
  String get errorMessage => statusMessage ?? '';
}

///502
class BadGateway extends Failure {
  final String? statusMessage;

  BadGateway(this.statusMessage);

  @override
  String get error => "BAD GATEWAY";

  @override
  int get errorCode => 502;

  @override
  String get errorMessage => statusMessage ?? '';
}

//503
class ServerUnavailable extends Failure {
  final String? statusMessage;

  ServerUnavailable(this.statusMessage);

  @override
  String get error => "SERVICE UNAVAILABLE";

  @override
  int get errorCode => 503;

  @override
  String get errorMessage => statusMessage ?? '';
}

///504
class GatewayTimeout extends Failure {
  final String? statusMessage;

  GatewayTimeout(this.statusMessage);

  @override
  String get error => "GATEWAY TIMEOUT";

  @override
  int get errorCode => 504;

  @override
  String get errorMessage => statusMessage ?? '';
}

///something went wrong
class UnknownError extends Failure {
  final String? statusMessage;

  UnknownError(this.statusMessage);

  @override
  String get error => "Something Went Wrong";

  @override
  int get errorCode => 0;

  @override
  String get errorMessage => statusMessage ?? '';
}

///No internet connection
class NoInternetConnection extends Failure {
  final String? statusMessage;

  NoInternetConnection(this.statusMessage);

  @override
  String get error => "No Internet Connection";

  @override
  int get errorCode => 1;

  @override
  String get errorMessage => statusMessage ?? '';
}

class ApiReturnNull extends Failure {
  final String? statusMessage;

  ApiReturnNull(this.statusMessage);

  @override
  String get error => "Api Return Null Value";

  @override
  int get errorCode => 2;

  @override
  String get errorMessage => statusMessage ?? '';
}

///Customizable error class with [errorMessage]
class CustomError extends Failure {
  final String? statusMessage;

  CustomError(this.statusMessage);

  @override
  String get error => errorMessage;

  @override
  int get errorCode => 5;

  @override
  String get errorMessage => statusMessage ?? '';
}
