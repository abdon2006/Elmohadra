import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/states/auth_states.dart';
import 'package:elmohadra/features/auth/presentation/screens/complete_profile_screen.dart';
import 'package:elmohadra/features/auth/presentation/screens/home_screen.dart';
import 'package:elmohadra/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatefulWidget {
  const new({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthStates>(
      builder: (context, state) {
        return switch (state) {
          AuthAuthenticated(:final user) => HomeScreen(),
          AuthNewUser(:final user) => CompleteProfileScreen(),
          AuthUnAuthenticated() => SignInScreen(),
          AuthInitial() || AuthLoading() => CircularProgressIndicator(),
          AuthError() => SignInScreen(),
        };
      },
    );
  }
}
