
import 'package:flutter/material.dart';

class CashFlowTable extends StatelessWidget {
  final double _totalIncome;
  final double _totalExpense;
  final int _incomeCount;
  final int _expenseCount;
  final int _durationPeriod;
  final String _durationText;
  final double _savings;
  CashFlowTable(this._savings,this._totalIncome,this._totalExpense,this._incomeCount,this._expenseCount,this._durationText,this._durationPeriod,);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  'Cash Flow Table',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                  ),
                ),// heading
                SizedBox(
                  height: 1.3,
                ),
                Text(
                  'Do I need any charts? ;-)',
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
                  _durationText.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                  ),
                ),// heading
                SizedBox(
                  height: 4,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Table(
              
              columnWidths: {
                1: FractionColumnWidth(0.4),
                2: FractionColumnWidth(0.2),
                3: FractionColumnWidth(0.2),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              children: [
                TableRow(

                  children: [
                    Text(
                      'Quick Overview',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Income',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Expenses',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ]
                ),
                TableRow(
                  children : <Widget> [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  children: [
                    Text(
                      'Count',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _incomeCount.toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _expenseCount.toString(),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ]
                ),
                TableRow(
                  children : <Widget> [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      'Average(Day)',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _totalIncome == 0 ? "0" :(_totalIncome/_durationPeriod).abs().toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _totalExpense == 0 ? "0" : (_totalExpense/_durationPeriod).abs().toStringAsFixed(2),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children : <Widget> [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  children: [
                    Text(
                      'Average(Record)',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _incomeCount == 0 ? "0" : (_totalIncome/_incomeCount).abs().toStringAsFixed(3),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _expenseCount == 0 ? "0" : (_totalExpense/ _expenseCount).abs().toStringAsFixed(3),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ]
                ),
                TableRow(
                  children : <Widget> [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _totalIncome.toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      _totalExpense.toString(),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ]
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Cash flow ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                  ),
                ),// heading
                SizedBox(
                  width: 5,
                ),
                Text(
                  _totalIncome > _totalExpense ? 'PKR ' + _savings.abs().toString() : '-PKR ' + _savings.abs().toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
             SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
          ],
        ),
      )
    );
  }
}