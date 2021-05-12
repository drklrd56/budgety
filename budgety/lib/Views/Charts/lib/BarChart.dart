import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import './Indicator.dart';
class ChartBar extends StatefulWidget {
  final List<BarChartGroupData> _rawBarGroups;
  final List<double> _yLabels;
  final List _xLabels;
  final Map<String,Object> _data;
  ChartBar(this._data, this._rawBarGroups, this._xLabels, this._yLabels);
  
  @override
  State<StatefulWidget> createState() => ChartBarState();
}

class ChartBarState extends State<ChartBar> {
  int touchedGroupIndex;
  List<BarChartGroupData> showingBarGroups = [];
  @override
  Widget build(BuildContext context) {
    showingBarGroups = widget._rawBarGroups;
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  makeTransactionsIcon(),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Cash Flow',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: BarChart(
                    BarChartData(
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.blueGrey,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          String selectedBar;
                          int index = group.x.toInt();
                          selectedBar = widget._xLabels[index];
                          return BarTooltipItem(
                            selectedBar + '\n' + 
                            'Income: ' + ((widget._data['income'] as List<double>)[index]).toStringAsFixed(3) + '\n' + 
                            'Expense: ' + ((widget._data['expense'] as List<double>)[index]).toStringAsFixed(3) + '\n' +
                            'Savings: ' + (((widget._data['income'] as List<double>)[index]) - ((widget._data['expense'] as List<double>)[index])).toStringAsFixed(3),
                            TextStyle(
                              color: Colors.yellow,
                              fontSize: 18,
                            )
                          );
                        }),
                        touchCallback: (barTouchResponse) {
                          setState(() {
                            if (barTouchResponse.spot != null &&
                                barTouchResponse.touchInput is! FlPanStart &&
                                barTouchResponse.touchInput is! FlLongPressEnd) {
                              touchedGroupIndex = barTouchResponse.spot.touchedBarGroupIndex;
                            } else {
                              touchedGroupIndex = -1;
                            }
                          });
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          textStyle: TextStyle(
                              color: const Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 20,
                          getTitles: (double value) {
                            return widget._xLabels[value.toInt()]; 
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          textStyle: TextStyle(
                              color: const Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 32,
                          reservedSize: 14,
                          getTitles: (value) {
                            if (value == 0) {
                              return getValue(4);
                            } else if (value == 1) {
                                return getValue(3);
                            } else if (value == 2) {
                                return getValue(2);
                            } else if (value == 3) {
                                return getValue(1);
                            } else if (value == 4) {
                                return getValue(0);
                            } else {
                                return ' ';
                            }
                          },
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: showingBarGroups,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Indicator(
                    color: Color(0xffff5182),
                    text: 'Expense',
                    isSquare: false,
                  ),
                  Indicator(
                    color: Color(0xff53fdd7),
                    text: 'Income',
                    isSquare: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),

            ],
          ),
        ),
      ),
    );
  }
  String getValue(int index) {
    int temp = widget._yLabels[index].toInt();
    String convert;
    if(temp >= 1000000000000000) {
      convert = temp.toString();
      convert = convert.substring(0,convert.length - 15) + 'QT';
    }
    else if(temp >= 1000000000000) {
      convert = temp.toString();
      convert = convert.substring(0,convert.length - 12) + 'T';
    }
    else if(temp >= 1000000000) {
      convert = temp.toString();
      convert = convert.substring(0,convert.length - 9) + 'B';
    }
    else if(temp >= 1000000) {
      convert = temp.toString();
      convert = convert.substring(0,convert.length - 6) + 'M';
    }
    else if(temp >= 1000) {
      convert = temp.toString();
      convert = convert.substring(0,convert.length - 3) + 'K';
    } else {
      convert = temp.toString();
    }
    return convert;
  }
  
  Widget makeTransactionsIcon() {
    const double width = 4.5;
    const double space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.black.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.black.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.black.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.black.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.black.withOpacity(0.4),
        ),
      ],
    );
  }
}