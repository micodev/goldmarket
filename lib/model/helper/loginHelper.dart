import 'package:goldmarket/model/core/user.dart';
import 'package:goldmarket/model/service/Api/SystemApi.dart';

class Loginhelper {
  final api = SystemApi();
  Future<User> loginUser(String username, String password) async {
    var loginUser = await api.login(username, password);
    return loginUser == null ? null : User.fromJson(loginUser);
  }
}
