import 'package:flutter/material.dart';

import '../../Models/Account.dart';
import '../Forms/TransactionForm.dart';
import '../Views/TransactionView.dart';
import '../../Models/Record.dart';
import '../../Models/Database.dart';
import'../../Models/Memory.dart';

class TransactionListView extends StatefulWidget {
  final Map<String,Object> _account;
  final int _selectedAccount;
  TransactionListView(this._account,this._selectedAccount);
  @override
  _TransactionListViewState createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView>  {
  
   void _editRecord(int recordIndex,Record record) async {
    setState(() {
      (accounts[widget._selectedAccount]['Transactions'] as List<Record>)[recordIndex] = record;
    });
    DatabaseHelper instance = DatabaseHelper.instance;
    await instance.updateRecord(record);
  }

  void _removeRecord(int recordIndex) async {
    int recordID = (widget._account['Transactions'] as List<Record>)[recordIndex].getRecordID;
    setState(() {
      (accounts[widget._selectedAccount]['Transactions'] as List<Record>).removeAt(recordIndex);
    });
    DatabaseHelper instance = DatabaseHelper.instance;
    await instance.deleteRecord(recordID);
  }

  @override
  Widget build(BuildContext context) {
    return Container( 
      child : Column(
        children: <Widget>[ 
          if(widget._account != null && (widget._account['Transactions'] as List<Record>) != null &&
           (widget._account['Transactions'] as List<Record>).length > 0)
          ...(widget._account['Transactions'] as List<Record>).asMap().entries.map((transaction) {
              return Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => 
                        TransactionForm([_editRecord,_removeRecord],transaction.key,widget._selectedAccount,2,transaction.value)
                        )
                      );
                    },
                    child:TransactionView(transaction.value,
                      (widget._account['Account'] as Account).getAccountName,
                      (widget._account['Account'] as Account).getCurrency.currencyCode),
                  ),
                  transaction.key == (widget._account['Transactions'] as List<Record>).length -1 
                  ? SizedBox(
                    width: 0,
                  )
                  : new Divider(
                    color: Colors.black,
                  ),
                ]
              );
            }
          ).toList(),
        ]
      ),
    );
  }
}