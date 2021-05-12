
import 'package:flutter/material.dart';
import '../../Models/Memory.dart';
import '../../Models/Search.dart';
import './lib/CashFlowTable.dart';
import './lib/CashFlowBook.dart';



class Report extends StatefulWidget {
  final int _selectedAccount,_selectedDuration;
  Report(this._selectedAccount,this._selectedDuration);
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List<Map<String,Object>> cashTable = [];
  List<Map<String,Object>> cashBook = [];
  String durationText;
  double savings;
  int durationPeriod;
  int incomeCount;
  int expenseCount;
  void step() {
    //super.initState();
    List results = [];
    DateTime time = DateTime.now();
    if(widget._selectedDuration == 0) {
      durationPeriod = 7;
      durationText = 'Last 7 Days';
    }
    else if(widget._selectedDuration == 1) {
      durationPeriod = 30;
      durationText = 'Last 30 Days';
    }
    else if(widget._selectedDuration == 2) {
      
      int days = time.month - 6;
      if(days <= 0) 
        days += 12;
      days = time.difference(new DateTime(time.year,days,time.day)).inDays;
      print(days);
      durationPeriod = 6 * days;
      durationText = 'Last 6 Months';
    }
    else if(widget._selectedDuration == 3) {
      durationPeriod = time.year % 4 == 0 ? 366 : 365;
      durationText = 'Last 1 Year';
    }
    if( widget._selectedAccount < accounts.length) {
      if(accounts[widget._selectedAccount].containsKey('Transactions')) {
        results = getRecords(widget._selectedAccount);
        if(widget._selectedDuration == 0)
          cashTable = getWeekRecords(results, widget._selectedAccount,returnType: 2);
        else if(widget._selectedDuration == 1)
          cashTable = getMonthRecords(results, widget._selectedAccount,returnType: 2);
        else if(widget._selectedDuration == 2)
          cashTable = get6MonthsRecords(results, widget._selectedAccount,returnType: 2);
        else if(widget._selectedDuration == 3)
          cashTable = getYearRecords(results, widget._selectedAccount,returnType: 2);
      }
    }
    savings = ((cashTable[0]['incExp']as List)[0] - (cashTable[0]['incExp']as List)[1]).abs();
  }
  double total = 0;
  void step2() {
    total = 0;
    cashBook = [];
    List results = [];
    List records = [];
    for(int i = 0; i < categories.length; i++) {
      if(accounts.length > 0 && widget._selectedAccount < accounts.length) {
        results = getRecords(widget._selectedAccount,property: categories[i]);
        if(widget._selectedDuration == 0)
          records.add(getWeekRecords(results, widget._selectedAccount,returnType: 2));
        else if(widget._selectedDuration == 1)
          records.add(getMonthRecords(results, widget._selectedAccount,returnType: 2));
        else if(widget._selectedDuration == 2)
          records.add(get6MonthsRecords(results, widget._selectedAccount,returnType: 2));
        else if(widget._selectedDuration == 3)
          records.add(get12MonthsRecords(results, widget._selectedAccount,returnType: 2));
        cashBook.add({
          'Income': ((records[i] as List<Map<String,Object>>)[0]['incExp'] as List)[0],
          'Expense': ((records[i] as List<Map<String,Object>>)[0]['incExp'] as List)[1],
        });
        total += (records[i] as List<Map<String,Object>>)[0]['Sum'] != null
        ? (records[i] as List<Map<String,Object>>)[0]['Sum']
        : 0;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    step();
    step2();
    //return Text('Hello');
    return SingleChildScrollView(
      child: Column (
        children: <Widget> [
          CashFlowTable( savings,(cashTable[0]['incExp']as List)[0],(cashTable[0]['incExp']as List)[1],
          cashTable[0]['incomeCount'],cashTable[0]['expenseCount'],durationText,durationPeriod),
          CashFlowBook(cashBook,total,durationText),
        ]
      ),
    );
  }
}