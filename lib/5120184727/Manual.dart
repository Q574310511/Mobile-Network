import 'package:flutter/material.dart';

class Manual extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('应用程序说明'),
          backgroundColor: Colors.blue,
        ),
        body: new Column(
            children: <Widget>[
            new Text(
              '版本：1.0.0',
              style: new TextStyle(
                  fontSize:25.0
              ),
            ),
          ],
        ),
    );
  }
}