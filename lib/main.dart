import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/constants/app_bloc_observer.dart';
import 'package:elmohadra/core/di/injection.dart';
import 'package:elmohadra/core/localization/locale_cubit.dart';
import 'package:elmohadra/core/routing/app_router.dart';
import 'package:elmohadra/core/routing/auth_notifier.dart';
import 'package:elmohadra/core/supabase/supabase_config.dart';
import 'package:elmohadra/core/theme/app_theme.dart';
import 'package:elmohadra/core/theme/theme_cubit.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/events/auth_events.dart';
import 'package:elmohadra/features/characters/presentation/bloc/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  late AppLinks appLinks;
  late StreamSubscription<Uri> appLinksListener;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(CheckAuthStatusEvent());
    appLinks = AppLinks();
    appLinksListener = appLinks.uriLinkStream.listen((uri) {
      context.read<AuthBloc>().add(DeepLinkReceivedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final theme = context.watch<ThemeCubit>().state;
        return MaterialApp.router(
          theme: AppTheme.light(context),
          darkTheme: AppTheme.dark(context),
          themeMode: theme.flutterThemeMode,
          debugShowCheckedModeBanner: false,
          title: "المحاضرة",
          routerConfig: appRouter(AuthNotifier(getIt<AuthBloc>())),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
