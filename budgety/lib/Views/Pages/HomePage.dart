
import 'package:flutter/material.dart';
import '../Pages/TransactionPage.dart';
import '../Cards/HomeCard.dart';
import '../../Models/Memory.dart';
import '../util/AppDrawer.dart';

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
      
      backgroundColor: Color(0xff4acd89),
        title: Text('Home'),
      ),
      backgroundColor: Colors.grey[200],
      body: HomeCard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(accounts!= null && accounts.length > 0) {
            Navigator.push(context,MaterialPageRoute(builder: (context) => 
            TransactionPage(accounts)));
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff4acd89),
      ),
    );
  }
}