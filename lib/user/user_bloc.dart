import 'package:bloc/bloc.dart';
import 'package:bloc_example/user/user_event.dart';
import 'package:bloc_example/user/user_service.dart';
import 'package:bloc_example/user/user_state.dart';
import 'package:flutter/material.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc({@required this.userService});

  @override
  UserState get initialState => UserStateNone();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserEventLoad) {
      yield UserStateLoading();
      final info = await userService.fetchUser(event.token, event.userId);
      yield UserStateLoaded(info: info);
    }
  }
}
