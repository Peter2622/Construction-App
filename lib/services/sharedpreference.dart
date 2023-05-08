import 'package:shared_preferences/shared_preferences.dart';

class Token {
  set token(token) {}

  void setToken(String token) async {
    SharedPreferences userLogin = await SharedPreferences.getInstance();
    userLogin.setString('token', token);
  }

  getToken() async {
    SharedPreferences token = await SharedPreferences.getInstance();

    return token.getString('token');
  }
}
