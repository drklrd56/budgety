import './lib/CashFlowSummary.dart';
import './lib/CashFlowTrend.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CashFlowPage extends StatefulWidget {
  final Map<String,Object> _cashFlow;
  final List<double> _yLabels;
  final List _xLabels;
  final List<BarChartGroupData> _rawBarGroups;
  
  CashFlowPage(this._cashFlow,this._xLabels,this._yLabels,this._rawBarGroups);
  @override
  _CashFlowPageState createState() => _CashFlowPageState();
}

class _CashFlowPageState extends State<CashFlowPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
      child: Column(
        children: <Widget>[
          CashFlowSummary(widget._cashFlow['durationText'],widget._cashFlow['savings'],widget._cashFlow['total'],
          widget._cashFlow['totalExpense'],widget._cashFlow['totalIncome']),
          CashFlowTrend(widget._cashFlow, widget._rawBarGroups, widget._xLabels, widget._yLabels),
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.transparent,
            child: Text(' '),
          ),
        ],
      ),
    );
  }
}