import 'package:bloc_example/user/user_info.dart';
import 'package:flutter/material.dart';

abstract class UserState {
  const UserState();
}

class UserStateNone extends UserState {
  @override
  String toString() => "UserStateNone";
}

class UserStateLoading extends UserState {
  @override
  String toString() => "UserStateLoading";
}

class UserStateLoaded extends UserState {
  final UserInfo info;

  const UserStateLoaded({@required this.info});

  @override
  String toString() => "UserStateLoaded";
}
