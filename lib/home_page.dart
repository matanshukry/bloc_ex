import 'package:bloc_example/page_b.dart';
import 'package:bloc_example/user_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHeader(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final nav = Navigator(
      key: _navKey,
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => PageB(),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Home Page"),
        Row(
          children: [
            RaisedButton(
              child: Text("Page A"),
              onPressed: () =>
                  UserPage.goTo(_navKey.currentState, UserPage.USER_A, this),
            ),
            RaisedButton(
              child: Text("Page B"),
              onPressed: () => PageB.goTo(_navKey.currentState, this),
            ),
          ],
        ),
        Expanded(child: nav),
      ],
    );
  }
}
