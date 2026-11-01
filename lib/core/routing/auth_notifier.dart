import 'dart:async';

import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/states/auth_states.dart';
import 'package:flutter/cupertino.dart';

/// Bridges [AuthBloc] state changes to a [Listenable] so GoRouter can refresh.
/// Own this object for the whole app lifetime and [dispose] it, otherwise the
/// stream subscription leaks.
class AuthNotifier extends ChangeNotifier {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthStates> _subscription;

  AuthNotifier(this.authBloc) {
    _subscription = authBloc.stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
