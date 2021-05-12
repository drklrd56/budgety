
import 'package:flutter/material.dart';

class CashFlowSummary extends StatefulWidget {
  final String _durationText;
  final double _savings;
  final double _totalIncome;
  final double _totalExpense;
  final double _total;
  CashFlowSummary(this._durationText,this._savings,this._total,this._totalExpense,this._totalIncome);
  @override
  _CashFlowSummaryState createState() => _CashFlowSummaryState();
}

class _CashFlowSummaryState extends State<CashFlowSummary> {
  
  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.fromLTRB(5, 5, 5, 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
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
                  'Cash Flow',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                  ),
                ),// heading
                SizedBox(
                  height: 1.3,
                ),
                Text(
                  'Am I spending less than I make?',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),// heading sub
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
                  widget._durationText.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                  ),
                ),// heading
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget._totalIncome > widget._totalExpense ? 'PKR ' + widget._savings.toString() : '-PKR ' + widget._savings.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),// heading sub
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Income',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        'PKR ' + widget._totalIncome.toString(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: widget._totalIncome / widget._total != 1.0 ? MediaQuery.of(context).size.width * (1 - (1 - (widget._totalIncome / widget._total)))
                                                        : MediaQuery.of(context).size.width * (0.9 - (1 - (widget._totalIncome / widget._total))),
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: widget._totalIncome /widget._total != 1.0 ? BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            topLeft: Radius.circular(4),
                          ): BorderRadius.circular(4),
                          color: Color(0xff4acd89),
                        ),
                        child: Text(' '),
                      )
                    ),
                    widget._totalIncome / widget._total != 1.0 ?
                    Container(
                      width: MediaQuery.of(context).size.width * (0.9 - (widget._totalIncome / widget._total)),
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: widget._totalIncome > 0 ? BorderRadius.only(
                            bottomRight: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ): BorderRadius.circular(4),
                          color: Colors.grey,
                        ),
                        child: Text(' '),
                      )
                    ): SizedBox(width: 0)
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Expense',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        '-PKR ' + widget._totalExpense.toString(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: widget._totalExpense/ widget._total != 1 ? MediaQuery.of(context).size.width * (1 - (1 - (widget._totalExpense / widget._total)).abs()).abs() 
                                                      : MediaQuery.of(context).size.width * (0.9 - (1 - (widget._totalExpense / widget._total)).abs()).abs(),
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: widget._totalExpense / widget._total != 1.0 ? BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            topLeft: Radius.circular(4),
                          ): BorderRadius.circular(4),
                          color: Colors.red,
                        ),
                        child: Text(' '),
                      )
                    ),
                    widget._totalExpense / widget._total != 1.0 ?
                    Container(
                      width: MediaQuery.of(context).size.width * (0.9 - (widget._totalExpense / widget._total).abs()).abs(),
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: widget._totalExpense > 0 ? BorderRadius.only(
                            bottomRight: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ) : BorderRadius.circular(4),
                          color: Colors.grey,
                        ),
                        child: Text(' '),
                      )
                    ): SizedBox(width: 0),                  
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}