import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/ui_demo/commmon/common_container.dart';
import 'package:sheet_widget_demo/ui_demo/pages/first_page.dart';
import 'package:sheet_widget_demo/ui_demo/pages/second_page.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class UiHomePage extends StatefulWidget {
  const UiHomePage({Key key}) : super(key: key);

  @override
  _UiHomePageState createState() => _UiHomePageState();
}

class _UiHomePageState extends State<UiHomePage> {
  TabController tabController;
  List pages = [
    ShowCase(),
    SecondPage(),
    SecondPage(),
    SecondPage(),
    SecondPage()
  ];
  int _selectedIndex = 0;

  void _onItemTappped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        extendBody: true,
        body: Container(
          child: pages[_selectedIndex],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            backgroundBlendMode: BlendMode.clear,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            boxShadow: [
              BoxShadow(color: grey, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          height: size.height * 0.07,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(fontSize: 12),
              currentIndex: _selectedIndex,
              onTap: _onItemTappped,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: showIndicator(_selectedIndex == 0)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.access_alarm),
                    title: showIndicator(_selectedIndex == 1)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    title: showIndicator(_selectedIndex == 2)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    title: showIndicator(_selectedIndex == 3)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    title: showIndicator(_selectedIndex == 4)),
              ],
              unselectedItemColor: grey.shade400,
              selectedItemColor: red,
            ),
          ),
        ),
      ),
    );
  }
}
