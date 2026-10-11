import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class LocalFailure extends Failure {
  const LocalFailure({required super.message});
}

class MatchMakingFailure extends Failure {
  const MatchMakingFailure({required super.message});
}

class BattleFailure extends Failure {
  const BattleFailure({required super.message});
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}
