import 'package:easy_localization/easy_localization.dart';
import 'package:elmohadra/core/localization/locale_cubit.dart';
import 'package:elmohadra/core/routing/app_router.dart';
import 'package:elmohadra/core/supabase/supabase_config.dart';
import 'package:elmohadra/core/theme/app_theme.dart';
import 'package:elmohadra/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:elmohadra/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    publishableKey: SupabaseConfig.supabasePublishableKey,
  );
  await EasyLocalization.ensureInitialized();
  await configureDependencies();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations/',
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<LocaleCubit>()),
          BlocProvider(create: (context) => getIt<ThemeCubit>()),
        ],
        child: ElmohadraApp(),
      ),
    ),
  );
}

class ElmohadraApp extends StatelessWidget {
  const ElmohadraApp({super.key});

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
          routerConfig: appRouter,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
