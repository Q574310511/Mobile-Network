import 'package:flutter/material.dart';
class login_02 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => login_02State();
}
class login_02State extends State<login_02>{
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('用户登录界面'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children:<Widget>[
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.phone),
              labelText: '请输入你的用户名)',
              helperText: '请输入注册的手机号',
            ),
            autofocus: false,
          ),
          TextField(
              controller: passController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.lock),
                labelText: '请输入密码)',
              ),
              obscureText: true),
          ElevatedButton(
            onPressed: _login,
            child: Text('登录'),
            style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.red)), ),
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
            title: Text('手机号码格式不对'),
          ));
    } else if (passController.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('请填写密码'),
          ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('登录成功'),
          ));
      phoneController.clear();
    }
  }

  void onTextClear() {
    setState(() {
      phoneController.clear();
      passController.clear();
    });
  }
}

