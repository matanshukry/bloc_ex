import 'package:bloc_example/page_b.dart';
import 'package:bloc_example/slide_right_route.dart';
import 'package:bloc_example/user/user_bloc.dart';
import 'package:bloc_example/user/user_event.dart';
import 'package:bloc_example/user/user_info.dart';
import 'package:bloc_example/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatefulWidget {
  static const USER_A = "foo";
  static const USER_B = "bar";

  const UserPage({Key key, this.userId}) : super(key: key);

  final String userId;

  @override
  State<StatefulWidget> createState() => _UserPageState();

  static void goTo(NavigatorState state, String userId, Widget old) {
    state.push(SlideRightRoute(page: UserPage(userId: userId), old: old));
  }
}

class _UserPageState extends State<UserPage> {
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();

    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.dispatch(UserEventLoad(
      token: "my-token",
      userId: widget.userId,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _userBloc,
      listener: (BuildContext context, UserState state) {
        if (state is UserStateLoaded) {
//          Scaffold.of(context).showSnackBar(SnackBar(
//            content: Text("Loaded user ${state.info.name} successfully!"),
//          ));
        }
      },
      child: BlocBuilder(
        bloc: _userBloc,
        builder: (BuildContext context, UserState state) {
          if (state is UserStateLoaded) {
            return _buildUserContent(state.info);
          }
          if (state is UserStateNone) {
            return _buildUserContent(UserInfo(
              id: "none",
              name: "none",
              photoUrl: "none",
            ));
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildUserContent(UserInfo info) {
    final friendId = getFriendId(info.id);
    return Column(children: [
      RaisedButton(
        child: Text("to Page B"),
        onPressed: () => _goToPageB(),
      ),
      Text("Id: ${info.id}"),
      Text("Name: ${info.name}"),
      Text("Photo Url: ${info.photoUrl}"),
      Text("Friends:"),
      RaisedButton(
        child: Text("Go to user $friendId"),
        onPressed: () => _goToUser(friendId.toLowerCase()),
      ),
    ]);
  }

  String getFriendId(String id) {
    return (id == UserPage.USER_A) ? UserPage.USER_B : UserPage.USER_A;
  }

  void _goToUser(String userId) {
    UserPage.goTo(Navigator.of(context), userId, widget);
  }

  void _goToPageB() {
    PageB.goTo(Navigator.of(context), widget);
  }
}
