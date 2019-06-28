import 'package:bloc_example/page_b.dart';
import 'package:bloc_example/slide_right_route.dart';
import 'package:bloc_example/user/user_bloc.dart';
import 'package:bloc_example/user/user_event.dart';
import 'package:bloc_example/user/user_info.dart';
import 'package:bloc_example/user/user_service.dart';
import 'package:bloc_example/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatelessWidget {
  static const USER_A = "foo";
  static const USER_B = "bar";

  const UserPage({Key key, this.userId}) : super(key: key);

  final String userId;

  static void goTo(NavigatorState state, String userId, Widget old) {
    state.push(
      SlideRightRoute(
        page: BlocProvider(
          builder: (context) =>
              UserBloc(userService: ImmutableProvider.of<UserService>(context))
                ..dispatch(UserEventLoad(
                  userId: userId,
                  token: "my-token",
                )),
          child: UserPage(userId: userId),
        ),
        old: old,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String getFriendId(String id) {
      return (id == UserPage.USER_A) ? UserPage.USER_B : UserPage.USER_A;
    }

    void _goToUser(String userId) {
      UserPage.goTo(Navigator.of(context), userId, this);
    }

    void _goToPageB() {
      PageB.goTo(Navigator.of(context), this);
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

    final _userBloc = BlocProvider.of<UserBloc>(context);
    return BlocListener(
      bloc: _userBloc,
      listener: (BuildContext context, UserState state) {
        if (state is UserStateLoaded) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Loaded user ${state.info.name} successfully!"),
          ));
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
}
