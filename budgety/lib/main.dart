import 'package:flutter/material.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart';
import './Models/Database.dart';
import'./Models/Account.dart';
import './Models/Memory.dart';
import './Views/Pages/HomePage.dart';

void main() async => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budgety',
      
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<List<Map<String,Object>>>_readAccounts() async {
    DatabaseHelper instance = DatabaseHelper.instance;

    List<Map<String,Object>> results = await instance.getAllAccounts();
    if(results == null) {
      results = [{'Data': 'None'}];
      return results;
    }
    for(int index = 0; index< results.length; index++) {
      results[index]['Transactions'] = await instance.getAllRecords((results[index]['Account'] as Account).getAccountID);
    }
    return results;
  }
  Future<List<Map<String,Object>>>_readLabels() async {
    DatabaseHelper instance = DatabaseHelper.instance;
    List<Map<String,Object>> results = await instance.getLabels();
    if(results == null) {
      results = [{'Data': 'None'}];
      return results;
    }
    return results;
  }

  @override
  void initState() {
    super.initState();
    Future<List<Map>> results = _readAccounts(); 
    results.then( (accountList) {
      if(accountList[0]['Data'] != 'None') {
        accountList.forEach((account) {
          accounts.add(account);
        });
      }
      results = _readLabels();
      results.then((labelList) {
        if(labelList[0]['Data'] != 'None') {
          labelList.forEach((label) {
            labels.add(label);
          });
        }
      });
      Navigator.pushReplacement(context, PageTransition(duration: Duration(seconds: 1), type: PageTransitionType.fade, child: MyHomePage()));
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

 