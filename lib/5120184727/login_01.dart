import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/5120184727/MainPage.dart';
class login_01 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => login_01State();
}
class login_01State extends State<login_01>{
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
        ],
      ),
    );
  }
  void _login() {
    print({'phone': phoneController.text, 'password': passController.text});
    if (phoneController.text.length != 11) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('用户名错误'),
          ));
    } else if (passController.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('请填写密码'),
          ));
    } else {
      /*showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('成功'),
          ));*/
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return BottomNavigationWidget();
      }));
      phoneController.clear();
      passController.clear();
    }
  }

  void onTextClear() {
      setState(() {
        phoneController.clear();
        passController.clear();
      });
  }
}

