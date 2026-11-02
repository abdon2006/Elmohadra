import 'package:flutter/foundation.dart';

/// The single door for diagnostics.
///
/// Every caught error goes through here before it is turned into a Failure,
/// so the raw type, message and stack stay available while debugging. In a
/// release build nothing is printed; wiring a real sink later means changing
/// this file only.
abstract class AppLogger {
  static void error(Object error, StackTrace stack) {
    if (!kDebugMode) return;

    debugPrint('┌──────────────────────────────────────────────');
    debugPrint('│ ❌ ${error.runtimeType}');
    debugPrint('│ $error');
    debugPrint('│ ${stack.toString().trim()}');
    debugPrint('└──────────────────────────────────────────────');
  }
}
