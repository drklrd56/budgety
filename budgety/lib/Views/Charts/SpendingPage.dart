
import 'package:budgety/Views/Views/TransactionView.dart';
import 'package:flutter/material.dart';
import './lib/PieChart.dart';
import '../../Models/Record.dart';
class SpendingPage extends StatefulWidget {
  final List _labelsData;
  final List _categoriesData;
  final Map<String,Object> _cashFlow;
  final String _accountName,_accountCurrency;
  SpendingPage(this._categoriesData,this._labelsData,this._cashFlow,this._accountName,this._accountCurrency);
  
  @override
  _SpendingPageState createState() => _SpendingPageState();
}

class _SpendingPageState extends State<SpendingPage> {
  List<Record> topExpenses= [];
  void initState(){
    super.initState();
    int length = (widget._cashFlow['expenses'] as List<Record>).length > 5 ? 5 : (widget._cashFlow['expenses'] as List<Record>).length; 
    for(int index = 0; index < length; index++) {
      topExpenses.add((widget._cashFlow['expenses'] as List<Record>)[index]);
    }
    topExpenses.sort(
      (a,b) => b.getAmount.compareTo(a.getAmount)
    );
  }
  int _graphType = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 3,
        margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child : Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    'Cash Flow Trend',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                    ),
                  ),
                  SizedBox(
                    height: 1.3,
                  ),
                  Text(
                    'In which periods was I saving more or less money?',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Divider(
                height: 2,
                color: Colors.black,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    (widget._cashFlow['durationText'] as String).toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
              _graphType == 0
              ? PieChart2(widget._categoriesData[0],widget._categoriesData[1],widget._categoriesData[2],widget._categoriesData[3])
              : PieChart2(widget._labelsData[0],widget._labelsData[1],widget._labelsData[2],widget._labelsData[3]),
              SizedBox(
                height: 2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'TOP 5 EXPENSES',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  ...topExpenses.map( (expense) {
                    return TransactionView(expense, widget._accountName, widget._accountCurrency);
                  }),
                ],
              ),
              Container(
                height: 150,
                width: double.infinity,
                color: Colors.transparent,
                child: Text(' '),
              )
            ]
          ),
        )
      ),
    );
  }
}


// (widget._account['Account'] as Account).getAccountName,
//                       (widget._account['Account'] as Account).getCurrency.currencyCode)