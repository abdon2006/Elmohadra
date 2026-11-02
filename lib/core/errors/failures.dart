import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;
  final StackTrace stackTrace;

  const Failure({required this.message, required this.stackTrace});
}

class ServerFailure extends Failure {
  final String? code;

  const ServerFailure({
    required super.message,
    this.code,
    required super.stackTrace,
  });

  @override
  List<Object?> get props => [message, code];
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, required super.stackTrace});

  @override
  List<Object?> get props => [message];
}

class LocalFailure extends Failure {
  const LocalFailure({required super.message, required super.stackTrace});

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends Failure {
  final String code;

  const AuthFailure({
    required super.message,
    required this.code,
    required super.stackTrace,
  });

  @override
  List<Object?> get props => [message, code];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.stackTrace});

  @override
  List<Object?> get props => [message];
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({required super.message, required super.stackTrace});

  @override
  List<Object?> get props => [message];
}

/// error in parsing jsons
class DataFailure extends Failure {
  const DataFailure({required super.message, required super.stackTrace});

  @override
  List<Object?> get props => [message];
}
