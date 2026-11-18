import 'package:elmohadra/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

/// The background image every route sits on.
///
/// It is installed once, in `MaterialApp.router`'s builder, so no screen
/// carries its own copy and a new screen gets it for free. That only works
/// because the scaffolds are transparent - an opaque scaffold would hide it.
///
/// The image is decoded once and reused; it is not a per-screen asset.
class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            isDark ? AppAssets.backgroundDark : AppAssets.backgroundLight,
            fit: BoxFit.cover,
            // The shards run diagonally, so centring keeps both corners in
            // frame while the aspect ratio is cropped.
            alignment: Alignment.center,
            gaplessPlayback: true,
          ),
        ),
        child,
      ],
    );
  }
}
