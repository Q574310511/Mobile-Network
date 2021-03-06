import 'package:flutter/material.dart';
import 'package:flutterapp/5120184727/Manual.dart';
import 'package:flutterapp/5120184727/Home.dart';
import 'package:flutterapp/5120184727/Personal.dart';

  class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
  }

  class BottomNavigationWidgetState extends State<NewsPage> {
  final _bottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = [];

  @override
  void initState() {
  list
  ..add(Home())
  ..add(Personal());
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:list[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  '้ฆ้กต',
                  style: TextStyle(color: _bottomNavigationColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  color: _bottomNavigationColor,
                ),
                title: Text(
                  'ๆ็',
                  style: TextStyle(color: _bottomNavigationColor),
                )),
          ],
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.shifting,
          onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        ),
    );
  }
}