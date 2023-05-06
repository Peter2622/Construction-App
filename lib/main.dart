import 'package:construction_app/screens/loginscreen.dart';
import 'package:construction_app/screens/selectsite.dart';
import 'package:flutter/material.dart';

import 'components/bottomnavcationbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
      // routes: <String, WidgetBuilder>{
      //   '/login': (context) => const LoginScreen(),
      //   '/selectsite': (context) => const SelectSite(),
      //   '/homescreen': (context) => BottomNav(),
      // },
      // initialRoute: '/login',

      home: BottomNav(),
    );
  }
}
