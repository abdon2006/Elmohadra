import 'package:elmohadra/core/errors/failures.dart';

class AppErrorTitleMapper {
  static String toKey(Failure failure) {
    return switch (failure) {
      NetworkFailure() => 'errors.network',
      TimeoutFailure() => 'errors.timeout',
      DataFailure() || LocalFailure() || CacheFailure() => 'errors.data',
      ServerFailure(:final code) => switch (code) {
        'unique_violation' => 'errors.db.unique_violation',
        'permission_denied' => 'errors.db.permission_denied',
        'not_found' => 'errors.db.not_found',
        'timeout' => 'errors.timeout',
        _ => 'errors.server',
      },
      AuthFailure(:final code) => switch (code) {
        'invalid_credentials' => 'errors.auth.invalid_credentials',
        'email_not_confirmed' => 'errors.auth.email_not_confirmed',
        'user_not_found' => 'errors.auth.user_not_found',
        'signup_failed' => 'errors.auth.signup_failed',
        'weak_password' => 'errors.auth.weak_password',
        'over_request_rate_limit' => 'errors.auth.over_request_rate_limit',
        'session_expired' => 'errors.auth.session_expired',
        'user_already_exists' => 'errors.auth.user_already_exists',
        'email_already_exists' => 'errors.auth.email_already_exists',
        'signup_disabled' => 'errors.auth.signup_disabled',
        'provider_disabled' => 'errors.auth.provider_disabled',
        'oauth_failed' => 'errors.auth.oauth_failed',
        'timeout' => 'errors.timeout',
        _ => 'errors.unknown',
      },
      _ => 'errors.unknown',
    };
  }
}

class AppErrorDescMapper {
  static String? toKey(Failure failure) {
    return switch (failure) {
      NetworkFailure() => 'errors.network_sub',
      TimeoutFailure() => 'errors.timeout_sub',
      DataFailure() || LocalFailure() || CacheFailure() => 'errors.data_sub',
      ServerFailure(:final code) => switch (code) {
        'timeout' => 'errors.timeout_sub',
        'unique_violation' || 'permission_denied' || 'not_found' => null,
        _ => 'errors.server_sub',
      },
      AuthFailure(:final code) => switch (code) {
        'invalid_credentials' => 'errors.auth.invalid_credentials_sub',
        'email_not_confirmed' => 'errors.auth.email_not_confirmed_sub',
        'user_not_found' => 'errors.auth.user_not_found_sub',
        'signup_failed' => 'errors.auth.signup_failed_sub',
        'weak_password' => 'errors.auth.weak_password_sub',
        'over_request_rate_limit' => 'errors.auth.over_request_rate_limit_sub',
        'session_expired' => 'errors.auth.session_expired_sub',
        'user_already_exists' => 'errors.auth.user_already_exists_sub',
        'email_already_exists' => 'errors.auth.email_already_exists_sub',
        'oauth_failed' => 'errors.auth.oauth_failed_sub',
        'timeout' => 'errors.timeout_sub',
        _ => null,
      },
      _ => null,
    };
  }
}
