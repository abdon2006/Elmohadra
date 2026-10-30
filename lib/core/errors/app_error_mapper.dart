import 'package:elmohadra/core/errors/failures.dart';

class AppErrorTitleMapper {
  static String toKey(Failure failure) {
    return switch (failure) {
      NetworkFailure() => 'errors.network',
      AuthFailure(:final code) => switch (code) {
        _ when code.contains('invalid_credentials') =>
          'errors.auth.invalid_credentials',
        _ when code.contains('email_not_confirmed') =>
          'errors.auth.email_not_confirmed',
        _ when code.contains('user_not_found') => 'errors.auth.user_not_found',
        _ => 'errors.unknown',
      },
      _ => 'errors.unknown',
    };
  }
}

class AppErrorDescMapper {
  static String? toKey(Failure failure) {
    return switch (failure) {
      AuthFailure(:final code) => switch (code) {
        _ when code.contains('invalid_credentials') =>
          'errors.auth.invalid_credentials_sub',
        _ => null,
      },
      _ => null,
    };
  }
}
