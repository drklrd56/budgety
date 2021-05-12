import 'package:flutter/material.dart';
import 'TransactionCard.dart';
import 'AccountCard.dart';
import '../../Models/Memory.dart';

class HomeCard extends StatefulWidget {
  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  int _selectedAccount = 0;

  void _changeSelected(int newSelected) {
    setState(() {
      this._selectedAccount = newSelected;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(_selectedAccount >= accounts.length && _selectedAccount != 0) {
      _changeSelected(0);
    }
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          AccountCard(context,accounts,_changeSelected),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          accounts.length > 0
          ?  TransactionCard(_selectedAccount, accounts[_selectedAccount])
          :  TransactionCard(_selectedAccount, null),           
        ],
      )
    );
  }
}