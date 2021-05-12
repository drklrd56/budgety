import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'Account.dart';
import 'Record.dart';

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "Wallet.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database 
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Account (
        AccountID INTEGER PRIMARY KEY,
        AccountName TEXT NOT NULL,
        Amount REAL NOT NULL,
        Currency TEXT NOT NULL,
        ViewColor TEXT NOT NULL,
        CreationTime TEXT NOT NULL
      )
      ''');
    await db.execute('''
      CREATE TABLE Record (
        RecordID INTEGER PRIMARY KEY,
        Amount REAL NOT NULL,
        Note TEXT,
        Payee TEXT,
        RecordType TEXT NOT NULL,
        Label TEXT,
        Category TEXT NOT NULL,
        RecordDate TEXT NOT NULL,
        PaymentType TEXT NOT NULL,
        AccountID INTEGER NOT NULL,
        CONSTRAINT FK_Account_Record FOREIGN KEY (AccountID) REFERENCES Account(AccountID) ON DELETE CASCADE ON UPDATE CASCADE
      )
      ''');
      await db.execute('''
      CREATE TABLE Label (
        LabelID INTEGER PRIMARY KEY,
        LabelName TEXT NOT NULL,
        ViewColor TEXT NOT NULL
      )
      ''');
  }

  //Database helper methods:
  
  Future<List<Record>> getAllRecords(int accountID) async{
    Database db = await database;
    List<Map> results = await db.query('Record',
    orderBy: "recordID ASC",
    where: 'AccountID = ?', whereArgs: [accountID]);
    
    if( results.length > 0 ) {
      List<Record> records = []; 
      results.forEach( (result) {
        records.add(Record.fromMap(result));
      });
      return records;
    }
    return null;
  }
  
  Future<List<Record>> getAllRecords2() async{
    Database db = await database;
    List<Map> results = await db.query('Record',
    orderBy: "recordID ASC",);
    if( results.length > 0 ) {
      List<Record> records = []; 
      results.forEach( (result) {
        records.add(Record.fromMap(result));
      });
      return records;
    }
    return null;
  }

  Future<Record> getRecord(int transactionID) async {
    Database db = await database;
    List<Map> results = await db.query('Record',where: 'RecordID = ?', whereArgs: [transactionID]);
    
    if( results.length > 0 ) {
      return Record.fromMap(results[0]);
    }
    return null;
  }

  Future<int> insertRecord(Record record) async {
    Database db = await database;
    var maxIdResult = await db.rawQuery("SELECT MAX(RecordID)+1 as last_inserted_id FROM Record"); 
    var maxId = maxIdResult.first["last_inserted_id"]; 
    if( maxId== null)
      maxId = 0;
    record.setRecordID = maxId;
    int id = await db.insert('Record', record.toMap());
    return id;
  } 
  
  Future<int> updateRecord(Record record) async {
    Database db = await database;
    int id = await db.update('Record', record.toMap(), where: 'RecordID = ?', whereArgs: [record.getRecordID]);
    return id;
  }

  Future<int> deleteRecord(int recordID) async {
    Database db = await database;
    int result = await db.delete('Record', where: "RecordID = ?", whereArgs: [recordID] );
    return result;
  }
  
  Future<int> insertAccount(Account account,Color viewColor) async {
    Database db = await database;
    var maxIdResult = await db.rawQuery("SELECT MAX(AccountID)+1 as last_inserted_id FROM Account"); 
    var maxId = maxIdResult.first["last_inserted_id"]; 
    if( maxId== null)
      maxId = 0;
    account.setAccountID = maxId;
    int id = await db.insert('Account', account.toMap(viewColor));
    return id;
  }

  Future<int> updateAccount(Account newAccount,Color viewColor) async {
    Database db = await database;
    int result = await db.update('Account', newAccount.toMap(viewColor),
    where: "AccountID = ?", whereArgs: [newAccount.getAccountID] );
    return result;
  }

  Future<int> deleteAccount(int id) async {
    Database db = await database;
    int result = await db.delete('Account', where: "AccountID = ?", whereArgs: [id] );
    return result;
  }

  Future<List<Map<String,Object>>> getAllAccounts() async {
    Database db = await database;
    List<Map> results = await db.query('Account', orderBy: "accountID ASC");
    if(results.length > 0) {
      List<Map<String,Object>> accounts = [];
      results.forEach( (account) {
        accounts.add(
          {
            'Account': Account.fromMap(account),
            'viewColor': Color(int.parse(account['ViewColor'])),
          }
        );
      });
      return accounts;
    }
    return null;
  }

  Future<Map<String,Object>> getAccount(int id) async {
    Database db = await database;
    List<Map> result = await db.query('Account',
      where: "AccountID = ?", whereArgs: [id]);
    if(result.length > 0) {
      return result[0];
    }
    return null;
  }

  Future<List<Map<String,Object>>> getLabels() async {
    Database db = await database;
    List<Map> results = await db.query('Label', orderBy: "LabelID ASC");
    if(results.length > 0) {
      List<Map<String,Object>> labels = [];
      results.forEach( (label) {
        labels.add(
          {
            'id': label['LabelID'],
            'Label': label['LabelName'],
            'viewColor': Color(int.parse(label['ViewColor'])),
          }
        );
      });
      return labels;
    }
    return null;
  }
  Future<int> insertLabel(String labelName, String color) async {
    Database db = await database;
    var maxIdResult = await db.rawQuery("SELECT MAX(LabelID)+1 as last_inserted_id FROM Label"); 
    var maxId = maxIdResult.first["last_inserted_id"]; 
    if( maxId== null)
      maxId = 0;
    int id = await db.insert('Label', {
      'LabelID': maxId,
      'LabelName': labelName,
      'ViewColor': color
    });
    return id;
  }

  Future<int> updateLabel(int id,String labelName, String color) async {
    Database db = await database;
    int result = await db.update('Label',
    {
      'LabelID': id,
      'LabelName': labelName,
      'ViewColor': color
    },where: "LabelID = ?", whereArgs: [id] );
    return result;
  }

  Future<int> deleteLabel(int id) async {
    Database db = await database;
    int result = await db.delete('Label', where: "LabelID = ?", whereArgs: [id] );
    return result;
  }

  void deleteAll() async {
    Database db = await database;
    
    await db.rawDelete('DELETE FROM Label;');
    await db.rawDelete('DELETE FROM Account');
    await db.rawDelete('DELETE FROM Record');
  }
}