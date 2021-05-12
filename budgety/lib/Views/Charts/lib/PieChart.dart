
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'Indicator.dart';

class PieChart2 extends StatefulWidget {
  final double _total;
  final List _indicators;
  final List _sections;
  final List _colors;
  PieChart2(this._total, this._sections, this._indicators, this._colors);
  @override
  _PieChart2State createState() => _PieChart2State();
}

class _PieChart2State extends State<PieChart2> {
  
  int touchedIndex;
  
  List<PieChartSectionData> showingSections() {
    return List.generate(widget._sections.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      double value = widget._sections[i]/widget._total;
      value *= 100;
      return PieChartSectionData(
        color: widget._colors[i],
        value: value,
        title: value.round().toString() + '%',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
   return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 18,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 18,
              ),
              makeTransactionsIcon(),
              const SizedBox(
                width: 28,
              ),
              const Text(
                'Pie Chart',
                style: TextStyle( fontSize: 22),
              ),
              const SizedBox(
                width: 4,
              ),
            ],
          ),
          widget._indicators.length > 0 ? Column (
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ...widget._indicators.asMap().entries.map((indicator) {
                      return Indicator(
                        color: widget._colors[indicator.key],
                        text: indicator.value,
                        isSquare: false,
                        size: touchedIndex == indicator.key ? 18 : 16,
                        textColor: touchedIndex == indicator.key ? Colors.black : Colors.grey,
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if(pieTouchResponse.touchInput is FlPanStart)
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 3,
                      centerSpaceRadius: 50,
                      sections: showingSections()
                    ),
                  )
                ],
              )
            ],
          ):
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
              child: Text('No records available..')
            )
          )
        ],
      ),
    );
    
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
