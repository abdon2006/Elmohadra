import 'package:elmohadra/core/theme/app_curves.dart';
import 'package:elmohadra/core/theme/app_duration.dart';
import 'package:elmohadra/core/theme/app_spacing.dart';
import 'package:elmohadra/core/widgets/app_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 500), () {
        if (mounted) setState(() => isLoading = true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/inSplash_screen.webp',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: AppSpacing.xxl.h,
            left: AppSpacing.lg.w,
            right: AppSpacing.lg.w,
            child: AnimatedOpacity(
              duration: AppDuration.slow,
              curve: AppCurves.standard,
              opacity: isLoading ? 1 : 0,
              child: AppLoadingIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
