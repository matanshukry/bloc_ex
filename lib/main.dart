import 'package:bloc/bloc.dart';
import 'package:bloc_example/home_page.dart';
import 'package:bloc_example/user/user_bloc.dart';
import 'package:bloc_example/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = PrintingBlocDelegate();

  runApp(MyApp());
}

class PrintingBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserService _userService;

  @override
  void initState() {
    super.initState();

    _userService = UserService();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<UserBloc>(
          builder: (BuildContext context) =>
              UserBloc(userService: _userService),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
