
import 'package:budgety/Models/Memory.dart';
import 'package:flutter/material.dart';

class CashFlowBook extends StatelessWidget {
  final double _total;
  final _durationText;
  final List<Map<String,Object>> _data;
  CashFlowBook(this._data,this._total,this._durationText);
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
                  'Income & Expense Book',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                  ),
                ),// heading
                SizedBox(
                  height: 1.3,
                ),
                Text(
                  'Charts are from dummies...',
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
                Text(
                  _total > 0 ? 'PKR ' + _total.abs().toString() : '-PKR ' + _total.abs().toString(),
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
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  Text(
                    'Income',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Expenses',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...categories.map((category){
                      return Container(
                        margin: EdgeInsets.all(5),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ..._data.map((entry){
                      return Container(
                        margin: EdgeInsets.all(5),
                        child: Text(
                          entry['Income'].toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ..._data.map((entry){
                      return Container(
                        margin: EdgeInsets.all(5),
                        child: Text(
                          entry['Expense'].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}