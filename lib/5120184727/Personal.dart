import 'package:flutter/material.dart';
import 'package:flutterapp/5120184727/ChangePwd.dart';

import 'package:flutterapp/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';

class Personal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonalState();
}

class PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children:<Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChangePwd();
                }));
              },
              child: Text('修改密码'),
            ),
          ]

    ));
  }
}