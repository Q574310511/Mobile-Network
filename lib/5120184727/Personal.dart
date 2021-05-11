import 'package:flutter/material.dart';

class Personal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonalState();
}

class PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:Text('个人详情',
          style: new TextStyle(
              fontSize:25.0
          ),
        ),

    );
  }
}