import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/5120184727/MainPage.dart';

import 'package:flutterapp/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePwd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ChangePwdState();
}
class ChangePwdState extends State<ChangePwd>{
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passcfmController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('修改密码'),
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
              hintText: '请输入账号',
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
            onPressed: _changePwd,
            child: Text('修改密码'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.purple),
            ),
            onPressed: (){Navigator.of(context)..pop();
            },
            child: Text('返回个人页面'),
          ),
        ],
      ),
    );

  }
  void _changePwd()  {
    Future<String> pwd = _GetPwd(phoneController.text);

    pwd.then((String pwd){
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
      }else if(passController.text == pwd) {
        showDialog(
            context: this.context,
            builder: (context) => AlertDialog(
              title: Text('密码与原密码一致'),
            ));
      } else {
        showDialog(
            context: this.context,
            builder: (context) => AlertDialog(
              title: Text('修改成功'),
            )
        );
        _Change(phoneController.text,passController.text);
        //延时3秒跳转
        Future.delayed(Duration(seconds: 1),(){
          Navigator.push(this.context, MaterialPageRoute(builder: (context) {
            return NewsPage();
          }));
        });
        onTextClear();
      }
    });
  }

  void onTextClear() {
    setState(() {
      phoneController.clear();
      passController.clear();
      passcfmController.clear();
    });
  }

}
_Change(String phone,String pwd) async {
  TableTestProvider testProvider = TableTestProvider();
  var databasePath = await getDatabasesPath();
  String path = join(databasePath,"demo.db");

  await testProvider.open(path);
  print('重新创建数据库');

  Test change = await testProvider.getTodo(phone);
  change.pwd = pwd;
  await testProvider.update(change);

  testProvider.close();
}

Future<String> _GetPwd(String phone) async{
  TableTestProvider testProvider = TableTestProvider();
  var databasePath = await getDatabasesPath();
  String path = join(databasePath,"demo.db");

  await testProvider.open(path);

  Test change = await testProvider.getTodo(phone);
  return change.pwd.toString();
}
