import 'dart:convert';

import 'package:construction_app/model/allsitemodle.dart';
import 'package:construction_app/services/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/colors.dart';
import '../services/sharedpreference.dart';

import 'package:http/http.dart' as http;

import '../services/singleton.dart';
import '../services/singleton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final login = GlobalKey<FormState>();
  final TextEditingController loginId = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool rememberMe = false;

  Future loginDetails(BuildContext context) async {
    var login = {"mobileNo": loginId.text, "pin": password.text};

    var loginData = jsonEncode(login);

    var loginRequest =
        await http.post(Uri.parse('http://89.116.231.138:8085/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "Access-Control-Allow-Origin": "*",
              "Access-Control-Allow-Headers":
                  "Origin,Content-Type,Authorization,Access-Control-Allow-Headers, X-Requested-With",
              "Access-Control-Allow-Methods": "POST, OPTIONS",
              // "Authorization": "Bearer ",
            },
            body: loginData);

    print('Status Code => ${loginRequest.statusCode}');
    print('LoginRequest Body => ${loginRequest.body}');

    var loginResponse = loginRequest.body;

    var loginResponseJson = jsonDecode(loginResponse);

    if (loginRequest.statusCode == 200) {
      print(loginResponseJson['token']);
      var token = loginResponseJson['token'];
      var userName = loginResponseJson['userName'];
       print(loginResponseJson['userName']);
      var role = loginResponseJson['role'];
       print(loginResponseJson['role']);
      print('loginResponseJson token => $token');
      Token loginForm = Token();
      loginForm.setToken(token);

      UserDetails userInfo = UserDetails();

      userInfo.setUsername(userName);
      userInfo.setUserRole(role);

      Navigator.pushNamed(context, '/selectsite');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Check user name & password')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
            ),
            Positioned(
              left: -40,
              top: -116,
              child: Container(
                width: 496,
                height: 496,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: primaryColor),
              ),
            ),
            const Positioned(
              top: 70,
              left: 130,
              child: SizedBox(
                  width: 117,
                  height: 71,
                  child: Image(image: AssetImage('images/logo.png'))),
            ),
            Positioned(
              left: 50,
              top: 200,
              child: Container(
                width: 299,
                height: 436,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4.0,
                          offset: Offset(0, 4))
                    ]),
                child: Form(
                  key: login,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 240,
                        height: 56,
                        child: TextFormField(
                            controller: loginId,
                            decoration: const InputDecoration(
                              hintText: 'Enter Login ID',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Your Login ID';
                              } else {
                                return null;
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 240,
                        height: 56,
                        child: TextFormField(
                            controller: password,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Your Password';
                              } else {
                                return null;
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      SizedBox(
                        child: CheckboxListTile(
                          title: const Text(
                            "Remember me",
                            style: TextStyle(fontSize: 15),
                          ),
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 238,
                        height: 44,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 0, 24, 35))),
                          onPressed: () async {
                            if (login.currentState!.validate()) {
                              loginDetails(context);
                            }
                          },
                          child: const Text(
                            'Log In',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                          onTap: () {},
                          child: const Text(
                            'Forget Password?',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 15),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 680,
              child: SizedBox(
                width: 359,
                height: 150,
                child: SvgPicture.asset(
                  'images/building.svg',
                  width: 360,
                  height: 150,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
