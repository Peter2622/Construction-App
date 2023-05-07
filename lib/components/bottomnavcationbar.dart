import 'package:construction_app/screens/debitentry.dart';
import 'package:construction_app/screens/stock.dart';
import 'package:construction_app/screens/worklog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'colors.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  List<Widget> screens = <Widget>[DebitEntry(), WorkLog(), Stock()];

  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // selectedFontSize: 20,
        selectedIconTheme: IconThemeData(color: primaryColor, size: 40),
        selectedItemColor: primaryColor,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'images/debit.svg',
                color: selectedIndex == 0 ? primaryColor : black,
                width: 24,
                height: 24,
              ),
              label: 'Debit'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                color: selectedIndex == 1 ? primaryColor : black,
                'images/worklog.svg',
                width: 24,
                height: 24,
              ),
              label: 'Worklog'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                color: selectedIndex == 2 ? primaryColor : black,
                'images/stock.svg',
                width: 24,
                height: 24,
              ),
              label: 'Stock'),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTap,
      ),
    );
  }
}
