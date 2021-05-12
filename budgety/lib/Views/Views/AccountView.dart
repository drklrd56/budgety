import 'package:flutter/material.dart';
import '../../Models/Account.dart';
import '../../Models/Record.dart';

class AccountView extends StatefulWidget {
  final Map<String,Object> _account;
  AccountView(this._account);
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  double _sumRecords() {
    double sum = (widget._account['Account'] as Account).getAmount; 
    if(widget._account.containsKey('Transactions')) {
      if(widget._account['Transactions'] != null) {
        for(int i = 0; i < (widget._account['Transactions'] as List<Record>).length; i++) {
          if((widget._account['Transactions'] as List<Record>)[i].getRecordType == 'income')
            sum += (widget._account['Transactions'] as List<Record>)[i].getAmount;
          else
            sum -= (widget._account['Transactions'] as List<Record>)[i].getAmount;
        }
      }
    }
    return sum;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget._account['viewColor'],
      ),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.40,
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              (widget._account['Account'] as Account).getAccountName,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          
          SizedBox(height:3),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                (widget._account['Account'] as Account).getCurrency.currencyCode.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(width:5),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text(
                  _sumRecords().toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}