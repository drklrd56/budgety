
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import './BarChart.dart';

class CashFlowTrend extends StatefulWidget {
  final List<BarChartGroupData> _rawBarGroups;
  final List<double> _yLabels;
  final List _xLabels;
  final Map<String,Object> _data;
  CashFlowTrend(this._data,this._rawBarGroups,this._xLabels,this._yLabels);
  @override
  _CashFlowTrendState createState() => _CashFlowTrendState();
}

class _CashFlowTrendState extends State<CashFlowTrend> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                  (widget._data['durationText'] as String).toUpperCase(),
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
            SizedBox(
              height: 2,
            ),
            ChartBar(widget._data, widget._rawBarGroups, widget._xLabels, widget._yLabels),
          ]
        ),
      )
    );
  }
}
