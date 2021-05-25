import 'package:flutter/material.dart';
import 'package:flutterapp/5120184727/Content.dart';
import 'package:flutterapp/5120184727/login_01.dart';

import 'package:http/http.dart' as http;
import 'package:flutterapp/5120184727/News.dart';
import 'dart:convert';
import 'package:flutterapp/5120184727/NewsDetail.dart';

Future<List<News>> getDatas() async{
  final response = await http.get(Uri.parse(
      'http://api.tianapi.com/dongman/index?key=af7811d0a8c2233f738f055b2be503b0&num=10&page=1'
  ));
  Utf8Decoder decode = new Utf8Decoder();
  Map<String, dynamic> result = jsonDecode(decode.convert(response.bodyBytes));
  List<News> datas;
  datas=result['newslist'].map<News>((item)=>News.fromJson(item)).toList();
  return datas;
}


class Acg extends StatefulWidget {
  @override
  State<StatefulWidget>  createState() => AcgState();
}


class AcgState extends State<Acg> {
  List<News> _datas = [];
  bool _cancelConnect = false;

  void initState()
  {
    getDatas().then((List<News> datas){
      if(!_cancelConnect)
      {
        setState(() {
          _datas = datas;
        });
      }
    }).catchError((e){
      print('error$e');
    }).whenComplete((){
      print('新闻获取完毕');
    }).timeout(Duration(seconds:5)).catchError((timeOut){
      print('超时:${timeOut}');
      _cancelConnect = true;
    });
  }

  Widget build(BuildContext context){
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: _handleRefresh,
        child:ListView.builder(
          itemCount: _datas.length,
          itemBuilder: (BuildContext context,int index){
            return Card(
              color:Colors.grey[250],
              elevation: 5.0,
              child:Builder(
                  builder: (context)=>InkWell(
                    child:new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(_datas[index].picUrl as String, fit: BoxFit.fitWidth,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:Text(
                            _datas[index].title.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding:_datas[index].description.toString().isEmpty
                              ? const EdgeInsets.all(0.0)
                              : const EdgeInsets.only(
                              left: 10.0,right: 10.0,bottom: 10.0),
                          child: Text(
                            _datas[index].description as String,
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                          child: Text(
                            '时间:${_datas[index].ctime}',
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap:()=>Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>NewsDetail(
                          url: _datas[index].url.toString(),
                          title: _datas[index].title.toString(),
                        ))),
                  )),
            );
          },
        ),
      ),
    );
  }

  Future _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _datas.clear();
        initState();
      });
    });
  }
}