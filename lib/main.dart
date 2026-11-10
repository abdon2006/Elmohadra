import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/constants/app_bloc_observer.dart';
import 'package:elmohadra/core/di/injection.dart';
import 'package:elmohadra/core/errors/app_error_mapper.dart';
import 'package:elmohadra/core/localization/locale_cubit.dart';
import 'package:elmohadra/core/routing/app_router.dart';
import 'package:elmohadra/core/routing/auth_notifier.dart';
import 'package:elmohadra/core/supabase/supabase_config.dart';
import 'package:elmohadra/core/theme/app_theme.dart';
import 'package:elmohadra/core/theme/theme_cubit.dart';
import 'package:elmohadra/core/widgets/app_toast.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/events/auth_events.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/states/auth_states.dart';
import 'package:elmohadra/features/characters/presentation/bloc/character_bloc.dart';
import 'package:elmohadra/features/subjects/presentation/bloc/subject_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    publishableKey: SupabaseConfig.supabasePublishableKey,
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  Bloc.observer = AppBlocObserver();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<LocaleCubit>()),
          BlocProvider(create: (context) => getIt<ThemeCubit>()),
          BlocProvider(create: (context) => getIt<AuthBloc>()),
          BlocProvider(create: (context) => getIt<CharacterBloc>()),
          BlocProvider(create: (context) => getIt<SubjectBloc>()),
        ],
        child: ElmohadraApp(),
      ),
    ),
  );
}

class ElmohadraApp extends StatefulWidget {
  const ElmohadraApp({super.key});

  @override
  State<ElmohadraApp> createState() => _ElmohadraAppState();
}

class _ElmohadraAppState extends State<ElmohadraApp> {
  late final AuthNotifier _authNotifier;
  late final GoRouter _router;
  late final StreamSubscription<Uri> _appLinksSubscription;
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void initState() {
    super.initState();
    // Created once so a rebuild never recreates the router (which would drop
    // the navigation stack and leak stream listeners).
    _authNotifier = AuthNotifier(getIt<AuthBloc>());
    _router = appRouter(_authNotifier);

    context.read<AuthBloc>().add(CheckAuthStatusEvent());
    _appLinksSubscription = AppLinks().uriLinkStream.listen((uri) {
      if (!mounted) return;
      if (uri.scheme == 'elmohadra' && uri.host == 'login-callback') {
        context.read<AuthBloc>().add(DeepLinkReceivedEvent());
      }
    });

    // The SDK exchanges the recovery link for a session in the background, and
    // only then reports `passwordRecovery`. Navigating on the raw link would open
    // the screen even when that exchange failed (expired link, or a link opened
    // on a device that holds another account's session).
    _authStateSubscription = Supabase.instance.client.auth.onAuthStateChange
        .listen((data) {
          if (!mounted) return;
          if (data.event == AuthChangeEvent.passwordRecovery) {
            context.read<AuthBloc>().add(PasswordResetLinkReceivedEvent());
          }
        });
  }

  @override
  void dispose() {
    _appLinksSubscription.cancel();
    _authNotifier.dispose();
    _router.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final theme = context.watch<ThemeCubit>().state;
        return ToastificationWrapper(
          child: MaterialApp.router(
            theme: AppTheme.light(context),
            darkTheme: AppTheme.dark(context),
            themeMode: theme.flutterThemeMode,
            debugShowCheckedModeBanner: false,
            title: "المحاضرة",
            routerConfig: _router,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            builder: (context, child) => BlocListener<AuthBloc, AuthStates>(
              listener: (context, state) {
                if (state is AuthNewUser && state.isGoogleSignIn) {
                  AppToast.show(
                    context: context,
                    title: 'toast.google_welcome'.tr(),
                    description: 'toast.google_welcome_sub'.tr(),
                    type: AppToastType.success,
                  );
                }
                if (state is AuthError) {
                  AppToast.show(
                    context: context,
                    title: AppErrorTitleMapper.toKey(state.failure).tr(),
                    type: AppToastType.error,
                    description: AppErrorDescMapper.toKey(state.failure)?.tr(),
                  );
                }
                if (state is ResetPasswordLinkSent) {
                  AppToast.show(
                    context: context,
                    title: 'signup.reset_pass_succeess_link'.tr(),
                    description: 'signup.reset_pass_succeess_link_sub'.tr(),
                    type: AppToastType.success,
                  );
                }
                if (state is PasswordUpdated) {
                  AppToast.show(
                    context: context,
                    title: 'toast.password_updated'.tr(),
                    description: 'toast.password_updated_sub'.tr(),
                    type: AppToastType.success,
                  );
                }
              },
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }
}
