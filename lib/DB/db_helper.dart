import 'dart:io';

import 'package:openwhatsappchat/Models/MobileNumberModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static const _databaseName = "whatsapp_data.db";
  static const _databaseVersion = 1;

  static final table = "save_wp_number";

  static final columnID = 'id';
  static final columnCountryCode = 'country_code';
  static final columnMobileNumber = 'mobile_number';
  static final columnDate = 'date';

  static Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async{
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db,int version) async{
    await db.execute(
      '''
      CREATE TABLE $table (
        $columnID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $columnCountryCode TEXT NOT NULL,
        $columnMobileNumber TEXT NOT NULL,
        $columnDate TEXT NOT NULL)
        '''
    );
  }

  //insert Data

  Future<int> insertData(MobileNumberModel mobileNumberModel) async{
    Database db = await instance.database;
    return await db.insert(table, mobileNumberModel.toMap());
  }

  // get specific data

  Future<bool> checkMobileNumber(String mobileNo) async {
    Database db = await instance.database;
    var res = await db.query(table, where: "$columnMobileNumber = ?", whereArgs: [mobileNo]);
    if(res.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  //get Data

  Future<List<Map<String, dynamic>>> getMobileNumberData() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(table,orderBy: '$columnID DESC');
    return result;
  }

  Future<List<MobileNumberModel>> getMobileNumberList() async {

    var numberList = await getMobileNumberData();
    int count = numberList.length;

    List<MobileNumberModel> noList = <MobileNumberModel>[];

    for (int i = 0; i < count; i++) {
      noList.add(MobileNumberModel.fromMapObject(numberList[i]));
    }

    return noList;
  }
  
  //delete

  Future<int> deleteData(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $table WHERE $columnID = $id');
    return result;
  }













}