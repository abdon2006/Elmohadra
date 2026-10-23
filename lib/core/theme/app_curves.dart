import 'package:flutter/material.dart';

abstract class AppCurves {
  static const Curve standard = Curves.easeInOutCubic;
  static const Curve enter = Curves.easeOut;
  static const Curve exit = Curves.easeIn;
  static const Curve bounce = Curves.elasticOut;
}
