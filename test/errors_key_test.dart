import 'dart:convert';
import 'dart:io';

import 'package:elmohadra/core/errors/app_error_mapper.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';

/// بيحوّل الـ json المتداخل لـ set من المسارات:
/// {"errors": {"auth": {"x": "..."}}}  →  {"errors.auth.x"}
Set<String> _flatKeys(Map<String, dynamic> json) {
  final keys = <String>{};

  void walk(Map<String, dynamic> node, String prefix) {
    node.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        walk(value, '$prefix$key.');
      } else {
        keys.add('$prefix$key');
      }
    });
  }

  walk(json, '');
  return keys;
}

void main() {
  final arKeys = _flatKeys(
    jsonDecode(File('assets/translations/ar.json').readAsStringSync())
        as Map<String, dynamic>,
  );
  final enKeys = _flatKeys(
    jsonDecode(File('assets/translations/en.json').readAsStringSync())
        as Map<String, dynamic>,
  );

  const authCodes = [
    'invalid_credentials',
    'email_not_confirmed',
    'user_not_found',
    'signup_failed',
    'weak_password',
    'over_request_rate_limit',
    'session_expired',
    'user_already_exists',
    'email_already_exists',
    'signup_disabled',
    'provider_disabled',
    'oauth_failed',
    'timeout',
    'unknown',
  ];

  const dbCodes = ['unique_violation', 'permission_denied', 'not_found'];

  final failures = <Failure>[
    const NetworkFailure(message: '', stackTrace: StackTrace.empty),
    const TimeoutFailure(message: '', stackTrace: StackTrace.empty),
    const DataFailure(message: '', stackTrace: StackTrace.empty),
    const LocalFailure(message: '', stackTrace: StackTrace.empty),
    const CacheFailure(message: '', stackTrace: StackTrace.empty),
    const ServerFailure(message: '', stackTrace: StackTrace.empty),
    for (final code in dbCodes)
      ServerFailure(message: '', code: code, stackTrace: StackTrace.empty),
    ServerFailure(message: '', code: 'timeout', stackTrace: StackTrace.empty),
    for (final code in authCodes)
      AuthFailure(message: '', code: code, stackTrace: StackTrace.empty),
  ];

  test('every key the mappers return exists in ar and en', () {
    for (final failure in failures) {
      final title = AppErrorTitleMapper.toKey(failure);
      final desc = AppErrorDescMapper.toKey(failure);
      final label = '${failure.runtimeType} -> $title';

      expect(arKeys.contains(title), isTrue, reason: 'AR ناقص: $label');
      expect(enKeys.contains(title), isTrue, reason: 'EN ناقص: $label');

      if (desc != null) {
        expect(arKeys.contains(desc), isTrue, reason: 'AR ناقص: $label (desc)');
        expect(enKeys.contains(desc), isTrue, reason: 'EN ناقص: $label (desc)');
      }
    }
  });

  test('ar and en have the same keys', () {
    expect(arKeys.difference(enKeys), isEmpty, reason: 'موجود في ar بس');
    expect(enKeys.difference(arKeys), isEmpty, reason: 'موجود في en بس');
  });
}
