import 'package:flutter/material.dart';

class Responsive {
  static Size size(BuildContext context) {
    return MediaQuery.sizeOf(context);
  }

  static bool isTablet(BuildContext context) {
    return size(context).shortestSide >= 600;
  }

  static bool isLandscape(BuildContext context) {
    final s = size(context);
    return s.width > s.height;
  }

  static double contentWidth(
    BuildContext context, {
    double maxWidth = 1000,
  }) {
    final s = size(context);

    if (!isTablet(context)) {
      return s.width;
    }

    return s.width.clamp(600.0, maxWidth);
  }

  static double scale(
    BuildContext context, {
    double base = 1.0,
    double max = 1.5,
  }) {
    final width = size(context).width;
    final factor = width / 360.0;

    return (factor * base).clamp(0.85, max);
  }
}