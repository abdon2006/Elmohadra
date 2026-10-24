import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthBloc authBloc;

  AuthNotifier(this.authBloc) {
    authBloc.stream.listen((_) => notifyListeners());
  }
}
