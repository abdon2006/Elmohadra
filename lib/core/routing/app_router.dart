import 'package:elmohadra/core/di/injection.dart';
import 'package:elmohadra/core/routing/app_routes.dart';
import 'package:elmohadra/core/routing/auth_notifier.dart';
import 'package:elmohadra/core/routing/main_shell.dart';
import 'package:elmohadra/core/widgets/app_button.dart';
import 'package:elmohadra/core/widgets/app_transition.dart';
import 'package:elmohadra/core/widgets/splash_screen.dart';
import 'package:elmohadra/features/auth/domain/usecases/signin_with_email_usecase.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/states/auth_states.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignIn%20Bloc/bloc/sign_in_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/SignUp%20Bloc/bloc/sign_up_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/signup_cubit/signup_cubit.dart';
import 'package:elmohadra/features/auth/presentation/screens/home_screen.dart';
import 'package:elmohadra/features/auth/presentation/screens/new_password_screen.dart';
import 'package:elmohadra/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:elmohadra/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:elmohadra/features/auth/presentation/screens/signup_screens/sign_up_screen.dart';
import 'package:elmohadra/features/user/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

GoRouter appRouter(AuthNotifier authNotifier) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: authNotifier,

    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(state: state, child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: AppRoutes.home,
            pageBuilder: (context, state) => buildPageTransition(
              context: context,
              state: state,
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.subjects,
            name: AppRoutes.subjects,
            pageBuilder: (context, state) => buildPageTransition(
              context: context,
              state: state,
              child: Scaffold(
                body: Center(
                  child: AppButton(
                    title: 'as;fjas;fl',
                    onTap: () {},
                    type: AppButtonType.primary,
                    isLoading: false,
                  ),
                ),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.vault,
            name: AppRoutes.vault,
            pageBuilder: (context, state) => buildPageTransition(
              context: context,
              state: state,
              child: Scaffold(
                body: AppButton(
                  title: 'as;fjas;fl',
                  onTap: () {},
                  type: AppButtonType.primary,
                  isLoading: false,
                ),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: AppRoutes.profile,
            pageBuilder: (context, state) => buildPageTransition(
              context: context,
              state: state,
              child: ProfileScreen(),
            ),
          ),
        ],
      ),

      GoRoute(
        path: AppRoutes.signin,
        name: AppRoutes.signin,
        pageBuilder: (context, state) => buildPageTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (context) => SignInBloc(
              signinWithEmailUsecase: getIt<SigninWithEmailUsecase>(),
            ),
            child: SignInScreen(),
          ),
        ),
      ),

      GoRoute(
        path: AppRoutes.signup,
        name: AppRoutes.signup,

        pageBuilder: (context, state) => buildPageTransition(
          context: context,
          state: state,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<SignupCubit>()),
              BlocProvider(create: (_) => getIt<SignUpBloc>()),
            ],
            child: SignUpScreen(),
          ),
        ),
      ),

      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splash,
        builder: (context, state) => SplashScreen(),
      ),

      GoRoute(
        path: AppRoutes.newPass,
        name: AppRoutes.newPass,
        builder: (_, state) => NewPassScreen(),
      ),
      GoRoute(
        path: AppRoutes.resetPass,
        name: AppRoutes.resetPass,
        builder: (_, state) => ResetPasswordScreen(),
      ),
    ],

    redirect: (context, state) {
      final authState = authNotifier.authBloc.state;
      final goingTo = state.matchedLocation;
      final allowedWhenUnauth = [
        AppRoutes.signin,
        AppRoutes.signup,
        AppRoutes.resetPass,
        AppRoutes.newPass,
      ];

      return switch (authState) {
        AuthInitial() => null,
        AuthLoading() => null,
        AuthAuthenticated() =>
          allowedWhenUnauth.contains(goingTo) || goingTo == AppRoutes.splash
              ? AppRoutes.home
              : null,
        AuthNewUser(user: var authresult) =>
          allowedWhenUnauth.contains(goingTo)
              ? null
              : Uri(
                  path: AppRoutes.signup,
                  queryParameters: {
                    if (authresult.newUseremail != null)
                      'email': authresult.newUseremail!,
                    if (authresult.newUserId != null)
                      'id': authresult.newUserId!,
                  },
                ).toString(),

        AuthUnAuthenticated() =>
          allowedWhenUnauth.contains(goingTo) ? null : AppRoutes.signin,
        AuthError() =>
          allowedWhenUnauth.contains(goingTo) ? null : AppRoutes.signin,
        ResetPasswordLinkSent() => null,
        ResetPasswordLinkReceived() => AppRoutes.newPass,
        PasswordUpdated() => null,
      };
    },
  );
}
