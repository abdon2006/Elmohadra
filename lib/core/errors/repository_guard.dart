import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failure_mapper.dart';
import 'package:elmohadra/core/errors/failures.dart';

Future<Either<Failure, T>> guard<T>(Future<T> Function() call) async {
  try {
    return Right(await call());
  } catch (e, s) {
    return Left(FailureMapper.map(e, s));
  }
}
