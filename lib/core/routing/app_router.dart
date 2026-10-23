import 'package:elmohadra/core/di/injection.dart';
import 'package:elmohadra/core/routing/app_routes.dart';
import 'package:elmohadra/core/routing/main_shell.dart';
import 'package:elmohadra/features/auth/domain/usecases/signin_with_email_usecase.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignIn%20Bloc/bloc/sign_in_bloc.dart';
import 'package:elmohadra/features/auth/presentation/screens/auth_gate.dart';
import 'package:elmohadra/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:elmohadra/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.signin,

  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainShell(state: state, child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: AppRoutes.home,
          builder: (context, state) =>
              Scaffold(body: Center(child: Text('home'))),
        ),
        GoRoute(
          path: AppRoutes.subjects,
          name: AppRoutes.subjects,
          builder: (context, state) =>
              Scaffold(body: Center(child: Text('subjects'))),
        ),
        GoRoute(
          path: AppRoutes.vault,
          name: AppRoutes.vault,
          builder: (context, state) =>
              Scaffold(body: Center(child: Text('vault'))),
        ),
        GoRoute(
          path: AppRoutes.profile,
          name: AppRoutes.profile,
          builder: (context, state) =>
              Scaffold(body: Center(child: Text('profile'))),
        ),
      ],
    ),

    GoRoute(
      path: AppRoutes.signin,
      name: AppRoutes.signin,
      builder: (context, state) => BlocProvider(
        create: (context) =>
            SignInBloc(signinWithEmailUsecase: getIt<SigninWithEmailUsecase>()),
        child: SignInScreen(),
      ),
    ),

    GoRoute(
      path: AppRoutes.signup,
      name: AppRoutes.signup,
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.authGate,
      name: AppRoutes.authGate,
      builder: (context, state) => AuthGate(),
    ),
  ],
);
