import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/5120184727/MainPage.dart';
import 'package:flutterapp/5120184727/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterapp/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';


class login_01 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => login_01State();
}
class login_01State extends State<login_01>{
  final String mUserPhone = "userPhone";
  final String mUserPwd = "userPwd";
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context){
      return Scaffold(
      appBar: AppBar(
        title: Text('用户登录界面'),
        backgroundColor: Colors.green,
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
              obscureText: true),

          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            onPressed: _login,
            child: Text('登录'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Register()));
            },
            child: Text('注册'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            onPressed: () {
              save();
            },
            child: Text('保存账号信息'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            onPressed: (){
              Future<String> userPhone = getphone();
              Future<String> userPwd = getpwd();
              userPhone.then((String userPhone){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("账号：$userPhone"))
                );
              });
              userPwd.then((String userPwd){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("密码：$userPwd"))
                );
              });
            },
            child: Text('查看登陆历史账号信息'),
          ),

        ],
      ),
    );
  }
  void _login() {
    print({'phone': phoneController.text, 'password': passController.text});
    Future<String> pwd = _GetPwd(phoneController.text);

    pwd.then((String pwd){
      if (phoneController.text.length != 11) {
        showDialog(
            context: this.context,
            builder: (context) => AlertDialog(
              title: Text('用户名错误'),
            ));
      } else if (passController.text.length == 0) {
        showDialog(
            context: this.context,
            builder: (context) => AlertDialog(
              title: Text('请填写密码'),
            ));
      }else if(passController.text != pwd){
        showDialog(
            context: this.context,
            builder: (context) => AlertDialog(
              title: Text('密码错误'),
            ));
      }
      else {
        Navigator.push(this.context, MaterialPageRoute(builder: (context) {
          return NewsPage();
        }));
        phoneController.clear();
        passController.clear();
      }
    });

  }

  void onTextClear() {
      setState(() {
        phoneController.clear();
        passController.clear();
      });
  }

  save() async{
    final phone = await SharedPreferences.getInstance();
    final password = await SharedPreferences.getInstance();
    phone.setString(mUserPhone,phoneController.value.text.toString());
    password.setString(mUserPwd,passController.value.text.toString());
  }

  Future<String> getphone() async {
    var userName;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName=prefs.get(mUserPhone);//取数据
    return userName;
  }

  Future<String> getpwd() async {
    var userPwd;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userPwd=prefs.get(mUserPwd);//取数据
    return userPwd;
  }
}

Future<String> _GetPwd(String phone) async{
  TableTestProvider testProvider = TableTestProvider();
  var databasePath = await getDatabasesPath();
  String path = join(databasePath,"demo.db");

  await testProvider.open(path);

  Test change = await testProvider.getTodo(phone);
  return change.pwd.toString();
}

