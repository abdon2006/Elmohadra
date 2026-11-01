import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Debug-only bloc tracing.
/// Payloads are intentionally not printed: events such as sign up carry the
/// password and states carry user data, so only types are logged.
class AppBlocObserver extends BlocObserver {
  void _log(String message) {
    if (kDebugMode) debugPrint(message);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _log('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _log('onEvent -- ${bloc.runtimeType} :: ${event.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _log('onChange -- ${bloc.runtimeType} :: ${change.nextState.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _log('onError -- ${bloc.runtimeType} :: ${error.runtimeType}');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _log('onClose -- ${bloc.runtimeType}');
  }
}
