import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
}

class ServerFailure extends Failure {
  final String? code;

  const ServerFailure({required super.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class LocalFailure extends Failure {
  const LocalFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class MatchMakingFailure extends Failure {
  const MatchMakingFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class BattleFailure extends Failure {
  const BattleFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends Failure {
  final String code;

  const AuthFailure({required super.message, required this.code});

  @override
  List<Object?> get props => [message, code];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

/// error in parsing jsons
class DataFailure extends Failure {
  const DataFailure({required super.message});

  @override
  List<Object?> get props => [message];
}
