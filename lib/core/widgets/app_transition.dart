import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<T> buildPageTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
        ),
      );

      final scale = TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween(
            begin: 1.15,
            end: 0.98,
          ).chain(CurveTween(curve: Curves.easeOutCubic)),
          weight: 70,
        ),
        TweenSequenceItem(
          tween: Tween(
            begin: 0.98,
            end: 1.0,
          ).chain(CurveTween(curve: Curves.easeOut)),
          weight: 30,
        ),
      ]).animate(animation);

      return FadeTransition(
        opacity: fade,
        child: ScaleTransition(scale: scale, child: child),
      );
    },
  );
}
