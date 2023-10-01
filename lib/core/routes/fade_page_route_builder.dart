import 'package:flutter/material.dart';

class FadePageRouteBuilder extends PageRouteBuilder {
  final WidgetBuilder builder;
  @override
  final RouteSettings settings;

  FadePageRouteBuilder({
    required this.builder,
    required this.settings,
  }) : super(
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              builder(context),
          settings: settings,
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            var tween = Tween(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: Curves.ease));
            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );
}
