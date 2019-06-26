import 'package:bloc_example/slide_right_route.dart';
import 'package:flutter/material.dart';

class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Page B"));
  }

  static void goTo(NavigatorState state, Widget old) {
    state.push(SlideRightRoute(page: PageB(), old: old));
  }
}
