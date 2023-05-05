import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNaviBar extends StatefulWidget {
  const BottomNaviBar({super.key});

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  int currentIndex = 0;
  List screens = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              currentIndex = value;
              print(value);
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.amber,
          elevation: 10,
          selectedLabelStyle: GoogleFonts.urbanist(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: currentIndex == 0 ),
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
                label: "Home",
                icon: Image.asset(
                  "assets/Home.png",
                  scale: currentIndex == 0 ? 1.5 : 2,
                  color: currentIndex == 0 ? primaryColor : black,
                )),
            BottomNavigationBarItem(
                label: "Employee",
                icon: Image.asset(
                  "assets/Employee.png",
                  scale: currentIndex == 1 ? 1.5 : 2,
                  color: currentIndex == 1 ? primaryColor : black,
                )),
            BottomNavigationBarItem(
                label: "Attendence",
                icon: Image.asset(
                  "assets/Attendence.png",
                  scale: currentIndex == 2 ? 1.5 : 2,
                  color: currentIndex == 2 ? primaryColor : black,
                ))
          ]),
    );
  }
}
