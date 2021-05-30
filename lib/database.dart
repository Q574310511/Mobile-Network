import 'package:sqflite/sqflite.dart';

final String tableName = 'table_user';
final String columnld = 'id';
final String columnPhone = 'phone';
final String columnPwd = 'pwd';

class Test{
  int? id;
  String? phone;
  String? pwd;

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      columnPhone:phone,
      columnPwd:pwd
    };
    if(id!=null){
      map[columnld] = id;
    }
    return map;
  }

  Test();

  Test.fromMap(Map<String, dynamic> map){
    id = map[columnld];
    phone = map[columnPhone];
    pwd = map[columnPwd];
  }
}

class TableTestProvider{
  Database? db;

  Future open(String path) async{
    db = await openDatabase(path,version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
      create table $tableName(
        $columnld integer primary key autoincrement,
        $columnPhone text not null,
        $columnPwd text not null)
      ''');
    });
  }

  Future<Test> insert(Test test) async{
    test.id = await db!.insert(tableName, test.toMap());
    return test;
  }

  Future<Test> getTodo(String phone) async{
    List<Map<String,dynamic>> maps = await db!.query(tableName,
      columns: [columnld,columnPhone,columnPwd],
      where: '$columnPhone = ?',
      whereArgs: [phone]);
    if(maps.length>0){
      return Test.fromMap(maps.first);
    }
    return Test();
  }

  Future<int> delete(String phone) async{
    return await db!.delete(tableName, where: '$columnPhone = ?',
    whereArgs: [phone]);
  }
  Future<int> update(Test test) async{
    return await db!.update(tableName, test.toMap(),
      where: '$columnld = ?', whereArgs: [test.id]);
  }
  Future close() async => db!.close();
}