import 'package:flutter/material.dart';
import 'package:flutterapp/5120184727/Content.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Text> content = [Text('印度疫情....',),Text('中国疫情....'),Text('美国疫情....'),Text('美国疫情分布....')];
  List<Image> News = [Image.asset('images/v1.jpg'),Image.asset('images/v2.jpg'),Image.asset('images/v3.jpg'),
                      Image.asset('images/v4.jpg')];
  Widget build(BuildContext context){
    return Center(
      child:ListView.builder(
        itemCount: News.length,
        itemBuilder: (BuildContext context,int index){
          //if(index.isOdd) return new Divider();
          return new TextButton(
            onPressed: () =>_look(index),
            child:News[index],
          );
        } //=> News[index],
      )
    );
  }

  void _look(int index) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(   // Add 20 lines from here...
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('详情',
              ),
            ),
            body: Center(
              child: content[index],
            ),
          );
        },
      ),
    );
  }
}