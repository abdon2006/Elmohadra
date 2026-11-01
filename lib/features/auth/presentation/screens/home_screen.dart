import 'package:elmohadra/core/widgets/app_toast.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/states/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthStates>(
        listener: (_, state) {
          if (state is AuthAuthenticated && state.isGoogleSignIn) {
            AppToast.show(
              context: context,
              title: "تم تسجيل الدخول عن طريق جوجل",
              type: AppToastType.success,
            );
          }
        },
        child: Center(child: Text("Home Screen")),
      ),
    );
  }
}
