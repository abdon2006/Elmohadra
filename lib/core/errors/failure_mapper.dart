import 'dart:io';

import 'package:elmohadra/core/errors/app_exceptions.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Maps raw exceptions thrown by the data layer to domain [Failure]s.
///
/// Keeping this in one place means every repository reports errors the same
/// way instead of duplicating the same `switch` in each method.
abstract class FailureMapper {
  static Failure map(Object error) {
    return switch (error) {
      InvalidCredentialsException() => AuthFailure(
        message: error.toString(),
        code: 'invalid_credentials',
      ),
      ProfileMissingException() => AuthFailure(
        message: error.toString(),
        code: 'user_not_found',
      ),
      AuthSignUpFailedException() => AuthFailure(
        message: error.toString(),
        code: 'signup_failed',
      ),
      EmailConfirmationRequiredException() => AuthFailure(
        message: error.toString(),
        code: 'email_not_confirmed',
      ),
      AuthRetryableFetchException() => NetworkFailure(message: error.message),

      AuthException() => AuthFailure(
        message: error.toString(),
        code: error.code ?? 'unknown',
      ),
      PostgrestException() => ServerFailure(message: error.toString()),
      StorageException() => ServerFailure(message: error.toString()),
      SocketException() => NetworkFailure(message: error.toString()),
      _ => ServerFailure(message: error.toString()),
    };
  }
}
