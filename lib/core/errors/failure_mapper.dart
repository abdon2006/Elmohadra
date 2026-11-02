import 'dart:async';
import 'dart:io';

import 'package:elmohadra/core/errors/app_exceptions.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class FailureMapper {
  static Failure map(Object error) {
    return switch (error) {
      // ============= our domain exceptions =============
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
      // ============= Sub Classes Before Auth Exceptions  =============
      AuthRetryableFetchException() => NetworkFailure(message: error.message),
      AuthWeakPasswordException() => AuthFailure(
        message: error.toString(),
        code: 'weak_password',
      ),
      AuthSessionMissingException() => AuthFailure(
        message: error.toString(),
        code: 'session_expired',
      ),
      AuthInvalidJwtException() => AuthFailure(
        message: error.toString(),
        code: 'session_expired',
      ),
      AuthPKCEGrantCodeExchangeError() => AuthFailure(
        message: error.toString(),
        code: 'oauth_failed',
      ),
      AuthUnknownException() => AuthFailure(
        message: error.toString(),
        code: _authCode(error.code),
      ),
      AuthException() => AuthFailure(
        message: error.toString(),
        code: error.code ?? 'unknown',
      ),

      // ============= Postgrest - Storage - Functions =============
      PostgrestException() => ServerFailure(
        message: error.toString(),
        code: _dbCode(error.code),
      ),
      StorageException() => ServerFailure(
        message: error.toString(),
        code: _statusCode(error.statusCode),
      ),
      FunctionsFetchException() => NetworkFailure(message: error.toString()),
      FunctionsRelayException() => ServerFailure(message: error.toString()),
      FunctionsHttpException() => ServerFailure(
        message: error.toString(),
        code: _httpCode(error.status),
      ),
      FunctionException() => ServerFailure(
        message: error.toString(),
        code: _httpCode(error.status),
      ),
      // ============= Dart - HTTP =============

      SocketException() => NetworkFailure(message: error.toString()),
      http.ClientException() => NetworkFailure(message: error.toString()),
      TimeoutException() => TimeoutFailure(message: error.toString()),
      FormatException() => DataFailure(message: error.toString()),
      TypeError() => DataFailure(message: error.toString()),
      _ => ServerFailure(message: error.toString()),
    };
  }

  static String _authCode(String? code) {
    return switch (code) {
      null => 'unknown',
      'email_exists' ||
      'phone_exists' ||
      'user_already_exists' => 'user_already_exists',
      'over_email_send_rate_limit' ||
      'over_sms_send_rate_limit' ||
      'over_request_rate_limit' => 'over_request_rate_limit',
      'session_missing' ||
      'session_not_found' ||
      'session_expired' ||
      'invalid_jwt' => 'session_expired',
      'email_provider_disabled' || 'provider_disabled' => 'provider_disabled',
      'anonymous_provider_disabled' || 'signup_disabled' => 'signup_disabled',
      'request_timeout' ||
      'hook_timeout' ||
      'hook_timeout_after_retry' => 'timeout',
      _ => code,
    };
  }

  static String? _dbCode(String? code) {
    return switch (code) {
      '23505' => 'unique_violation',
      '42501' => 'permission_denied',
      'PGRST116' => 'not_found',
      _ => null,
    };
  }

  static String? _statusCode(String? status) {
    return switch (status) {
      '401' || '403' => 'permission_denied',
      '404' => 'not_found',
      _ => null,
    };
  }

  static String? _httpCode(int status) {
    return switch (status) {
      401 || 403 => 'permission_denied',
      404 => 'not_found',
      408 || 504 => 'timeout',
      _ => null,
    };
  }
}
