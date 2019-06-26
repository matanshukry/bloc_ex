import 'package:flutter/material.dart';

abstract class UserEvent {
  const UserEvent();
}

class UserEventLoad extends UserEvent {
  final String token;
  final String userId;

  const UserEventLoad({@required this.token, @required this.userId});

  @override
  String toString() => "UserEventLoad";
}
