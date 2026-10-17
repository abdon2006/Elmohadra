import 'package:elmohadra/core/routing/app_routes.dart';
import 'package:elmohadra/core/widgets/app_fab.dart';
import 'package:flutter/material.dart';
import 'package:elmohadra/core/widgets/app_bottom_nav.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  final GoRouterState state;
  const MainShell({super.key, required this.child, required this.state});

  @override
  Widget build(BuildContext context) {
    final path = state.matchedLocation;
    final int currentIndex = switch (path) {
      /// here we handle the last 2 pages like that because the dummy page we put at the bottom nav
      AppRoutes.home => 0,
      AppRoutes.subjects => 1,
      AppRoutes.vault => 3,
      AppRoutes.profile => 4,
      _ => 0,
    };
    return Scaffold(
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: 
      
      AppFab()
      ,
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(AppRoutes.home);
              break;
            case 1:
              context.go(AppRoutes.subjects);
              break;
            case 3:
              context.go(AppRoutes.vault);
              break;
            case 4:
              context.go(AppRoutes.profile);
              break;
          }
        },
      ),
    );
  }
}
