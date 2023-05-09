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

class UserDetails {
  set user(user) {}

  void setUsername(String userName) async {
    SharedPreferences userNameDetails = await SharedPreferences.getInstance();
    userNameDetails.setString('userName', userName);
  }

  getUsername() async {
    SharedPreferences usernameInfo = await SharedPreferences.getInstance();

    return usernameInfo.getString('userName');


    
  }

  void setUserRole(String userrole) async {
    SharedPreferences userroleDetails = await SharedPreferences.getInstance();
    userroleDetails.setString('role', userrole);
  }

  getUserRole() async {
    SharedPreferences userroleInfo = await SharedPreferences.getInstance();

    return userroleInfo.getString('role');


    
  }
}





