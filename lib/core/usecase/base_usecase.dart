import 'package:dartz/dartz.dart';
import 'package:elmohadra/core/errors/failures.dart';

abstract class BaseUsecase<R, P> {
  Future<Either<Failure, R>> call(P params) ;
}

class NoParams{}