import 'package:elmohadra/core/routing/app_routes.dart';
import 'package:elmohadra/core/routing/main_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
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
  ],
);
