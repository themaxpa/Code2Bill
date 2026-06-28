import 'package:flutter/material.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveScaffold({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1100) {
      return desktop;
    } else if (width >= 600) {
      return tablet;
    } else {
      return mobile;
    }
  }
}