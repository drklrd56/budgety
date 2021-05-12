import 'package:flutter/material.dart';
import '../../Models/Record.dart';
import '../Pages/SearchPage.dart';
import '../Views/TransactionListView.dart';

class TransactionCard extends StatefulWidget {
  final int _selectedAccount;
  final Map<String,Object> _account;
  TransactionCard(this._selectedAccount,this._account) {
    if(this._account != null) {
      if((this._account['Transactions'] as List<Record>) == null || (this._account['Transactions'] as List<Record>).length <= 0)
        this._account['Transactions'] = new List<Record>();
    }
  }

  @override
  _TransactionCardState createState() => _TransactionCardState();
}
class _TransactionCardState extends State<TransactionCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 5,
      child: Container (
        decoration: BoxDecoration(
          
          border: Border.all(
            width: 2,
            color: Colors.grey,
          )
        ),
        child: Column (
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Text(
                  'Last Records Overview',
                  style: TextStyle(
                    fontSize: 20
                  )
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TransactionListView(widget._account, widget._selectedAccount),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: 
            <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage(widget._selectedAccount),)
                  );
                },
                  child: Text(
                    'SHOW MORE',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  )
                )
              ]
            ),
          ]
        )
      )
    );
  }
}