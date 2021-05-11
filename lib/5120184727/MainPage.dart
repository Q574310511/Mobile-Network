import 'package:flutter/material.dart';
import 'package:flutterapp/5120184727/Manual.dart';
import 'package:flutterapp/5120184727/Home.dart';
import 'package:flutterapp/5120184727/Personal.dart';

/*class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //去掉debug标签
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('晖的新闻浏览器'),
          //标题不居中
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.backspace),
            onPressed: () {
              Navigator.of(context)..pop();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.adjust),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Manual();
                }));
              },
            ),
          ],

        ),
      ),
    );
  }
}*/

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}
class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _bottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = List();

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
      appBar: AppBar(
        title: Text('晖的新闻浏览器'),
        backgroundColor: Colors.lightBlue,
        //标题不居中
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.backspace),
          onPressed: () {
            Navigator.of(context)..pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.adjust),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Manual();
              }));
            },
          ),
        ],

      ),
      body:list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '首页',
                style: TextStyle(color: _bottomNavigationColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '我的',
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