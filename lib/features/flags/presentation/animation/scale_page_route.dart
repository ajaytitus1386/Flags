import 'package:flutter/material.dart';

PageRouteBuilder<dynamic> scalePageBuilder(Widget child) {
  return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secAnimation, Widget child) {
        animation =
            CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic);
        return ScaleTransition(
          scale: animation,
          child: child,
          alignment: Alignment.center,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secAnimation) {
        return child;
      });
}
