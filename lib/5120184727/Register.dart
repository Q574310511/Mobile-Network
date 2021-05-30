import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/5120184727/login_01.dart';

import 'package:flutterapp/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => RegsterState();
}
class RegsterState extends State<Register>{
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passcfmController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children:<Widget>[
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.person),
              hintText: '请输入手机号',
              labelText: '账号',
            ),
            autofocus: false,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly,//只允许输入数字
              LengthLimitingTextInputFormatter(11)],
          ),
          TextField(
              controller: passController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.lock),
                labelText: '请输入密码',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp("[^\u4e00-\u9fa5]")),
                LengthLimitingTextInputFormatter(16),
              ],
              obscureText: true
          ),
          TextField(
              controller: passcfmController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.lock),
                labelText: '请输入确认密码',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp("[^\u4e00-\u9fa5]")),
                LengthLimitingTextInputFormatter(16),
              ],
              obscureText: true
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.purple),
            ),
            onPressed: _register,
            child: Text('注册'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.purple),
            ),
            onPressed: (){Navigator.of(context)..pop();
            },
            child: Text('返回登陆'),
          ),
        ],
      ),
    );

  }
  void _register() {
    if (phoneController.text.length != 11) {
      showDialog(
          context: this.context,
          builder: (context) => AlertDialog(
            title: Text('请输入正确的手机号'),
          ));
    } else if (passController.text.length == 0) {
      showDialog(
          context: this.context,
          builder: (context) => AlertDialog(
            title: Text('请填写密码'),
          ));
    }
    else if (passcfmController.text.length == 0) {
      showDialog(
          context: this.context,
          builder: (context) => AlertDialog(
            title: Text('请填写确认密码'),
          ));
    }
    else if (passController.text != passcfmController.text) {
      showDialog(
          context: this.context,
          builder: (context) => AlertDialog(
            title: Text('两次密码不一致'),
          ));
    }
    else {
      showDialog(
          context: this.context,
          builder: (context) => AlertDialog(
            title: Text('注册成功'),
          )
      );
      _querySQLHelper(phoneController.text,passController.text);
      //延时3秒跳转
      Future.delayed(Duration(seconds: 1),(){
        Navigator.push(this.context, MaterialPageRoute(builder: (context) {
          return login_01();
        }));
      });
      onTextClear();
    }
  }

  void onTextClear() {
    setState(() {
      phoneController.clear();
      passController.clear();
      passcfmController.clear();
    });
  }

}
_querySQLHelper(String phone,String pwd) async {
  TableTestProvider testProvider = TableTestProvider();
  var databasePath = await getDatabasesPath();
  String path = join(databasePath,"demo.db");

  await testProvider.open(path);
  print('重新创建数据库');

  Test test = Test();
  test.phone = phone;
  test.pwd = pwd;
  Test td = await testProvider.insert(test);
  print('inserted:${td.toMap()}');

  testProvider.close();
}

