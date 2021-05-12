
import 'package:flutter/material.dart';
import './lib/CashFlowTable.dart';
import './lib/CashFlowBook.dart';



class ReportPage extends StatefulWidget {
  final Map<String,Object> _cashTable;
  final List<Map<String,Object>> _cashBook;
  final double _total;
  ReportPage(this._cashTable,this._cashBook,this._total);
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  @override
  Widget build(BuildContext context) {
    // print(widget._cashTable);
    // print(widget._cashBook);
    return SingleChildScrollView(
      child: Column (
        children: <Widget> [
          CashFlowTable(widget._cashTable['savings'], widget._cashTable['totalIncome'], widget._cashTable['totalExpense'],
          widget._cashTable['incomeCount'], widget._cashTable['expenseCount'], widget._cashTable['durationText'], widget._cashTable['durationPeriod']),
          CashFlowBook(widget._cashBook,widget._total,widget._cashTable['durationText']),
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.transparent,
            child: Text(' '),
          ),
        ]
      ),
    );
  }
}