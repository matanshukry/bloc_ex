import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  final Widget old;

  SlideRightRoute({@required this.page, @required this.old})
      : super(
            transitionDuration: const Duration(milliseconds: 3000),
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return SlideTransition(
                position:
                    Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
                        .animate(animation),
                child: child,
              );
            });
}
