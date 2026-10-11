import 'package:elmohadra/core/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.home,
      builder: (context, state) => Scaffold(
        backgroundColor: Color(0xffF5F0E8),
        body: Center(child: Text('home')),
      ),
    ),
    GoRoute(
      path: AppRoutes.battle,
      name: AppRoutes.battle,
      builder: (context, state) =>
          Scaffold(body: Center(child: Text('battle'))),
    ),
    GoRoute(
      path: AppRoutes.friends,
      name: AppRoutes.friends,
      builder: (context, state) =>
          Scaffold(body: Center(child: Text('friends'))),
    ),
    GoRoute(
      path: AppRoutes.profile,
      name: AppRoutes.profile,
      builder: (context, state) =>
          Scaffold(body: Center(child: Text('profile'))),
    ),
  ],
);
