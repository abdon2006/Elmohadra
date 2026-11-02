import 'dart:async';
import 'dart:io';

import 'package:elmohadra/core/errors/app_exceptions.dart';
import 'package:elmohadra/core/errors/failure_mapper.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  String? _codeOf(Failure failure) {
    if (failure is AuthFailure) return failure.code;
    if (failure is ServerFailure) return failure.code;
    return null;
  }

  Object _typeError() {
    try {
      final dynamic value = 'not an int';
      return value as int;
    } catch (e) {
      return e;
    }
  }

  void _check(Object error, Type expectedType, String? expectedCode) {
    final failure = FailureMapper.map(error, StackTrace.empty);

    expect(failure.runtimeType, expectedType);
    expect(_codeOf(failure), expectedCode);
  }

  test('postgrest permission denied', () {
    _check(
      PostgrestException(message: 'rls', code: '42501'),
      ServerFailure,
      'permission_denied',
    );
  }); // ── استثناءاتنا ──────────────────────────────────────
  test('profile missing', () {
    _check(const ProfileMissingException('u1'), AuthFailure, 'user_not_found');
  });

  test('sign up failed', () {
    _check(const AuthSignUpFailedException(), AuthFailure, 'signup_failed');
  });

  test('email confirmation required', () {
    _check(
      const EmailConfirmationRequiredException(),
      AuthFailure,
      'email_not_confirmed',
    );
  });

  // ── auth ─────────────────────────────────────────────
  test('retryable fetch is a network failure', () {
    _check(AuthRetryableFetchException(), NetworkFailure, null);
  });

  test('weak password', () {
    _check(
      AuthWeakPasswordException(
        message: 'too weak',
        statusCode: '422',
        reasons: const ['length'],
      ),
      AuthFailure,
      'weak_password',
    );
  });

  test('session missing', () {
    _check(AuthSessionMissingException(), AuthFailure, 'session_expired');
  });

  test('invalid jwt', () {
    _check(AuthInvalidJwtException('bad'), AuthFailure, 'session_expired');
  });

  test('pkce exchange failed', () {
    _check(
      AuthPKCEGrantCodeExchangeError('bad code'),
      AuthFailure,
      'oauth_failed',
    );
  });

  test('unknown auth error', () {
    _check(
      AuthUnknownException(message: 'boom', originalError: 'raw'),
      AuthFailure,
      'unknown',
    );
  });

  test('sdk code is normalized', () {
    _check(
      AuthApiException('exists', code: 'email_exists'),
      AuthFailure,
      'user_already_exists',
    );
  });

  test('known sdk code passes through', () {
    _check(
      AuthException('pending', code: 'email_not_confirmed'),
      AuthFailure,
      'email_not_confirmed',
    );
  });

  test('auth error without code', () {
    _check(AuthException('no code'), AuthFailure, 'unknown');
  });

  // ── postgrest / storage / functions ──────────────────
  test('db unique violation', () {
    _check(
      PostgrestException(message: 'dup', code: '23505'),
      ServerFailure,
      'unique_violation',
    );
  });

  test('db not found', () {
    _check(
      PostgrestException(message: 'none', code: 'PGRST116'),
      ServerFailure,
      'not_found',
    );
  });

  test('db unknown code stays generic', () {
    _check(
      PostgrestException(message: 'other', code: '42P01'),
      ServerFailure,
      null,
    );
  });

  test('storage forbidden', () {
    _check(
      StorageException('denied', statusCode: '403'),
      ServerFailure,
      'permission_denied',
    );
  });

  test('function fetch is a network failure', () {
    _check(FunctionsFetchException(), NetworkFailure, null);
  });

  test('function http 404', () {
    _check(FunctionsHttpException(status: 404), ServerFailure, 'not_found');
  });

  test('function http 500 stays generic', () {
    _check(FunctionException(status: 500), ServerFailure, null);
  });

  // ── dart / http ──────────────────────────────────────
  test('socket is a network failure', () {
    _check(const SocketException('offline'), NetworkFailure, null);
  });

  test('http client is a network failure', () {
    _check(http.ClientException('offline'), NetworkFailure, null);
  });

  test('timeout', () {
    _check(TimeoutException('slow'), TimeoutFailure, null);
  });

  test('format is a data failure', () {
    _check(const FormatException('bad json'), DataFailure, null);
  });

  test('type error is a data failure', () {
    _check(_typeError(), DataFailure, null);
  });

  test('anything else is a server failure', () {
    _check('raw string from realtime', ServerFailure, null);
  });

  // ── الستاك بيوصل زي ما هو ─────────────────────────────
  test('mapper keeps the stack trace', () {
    final stack = StackTrace.current;
    final failure = FailureMapper.map(
      const InvalidCredentialsException(),
      stack,
    );

    expect(failure.stackTrace, same(stack));
  });
}
