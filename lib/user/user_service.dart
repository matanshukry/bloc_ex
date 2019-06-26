import 'package:bloc_example/user/user_info.dart';

class UserService {
  Future<UserInfo> fetchUser(String token, String userId) async {
    await Future.delayed(const Duration(seconds: 1));

    return UserInfo(
      id: userId,
      name: "User $userId",
      photoUrl: "https://mysite.com/pictures/$userId",
    );
  }
}
