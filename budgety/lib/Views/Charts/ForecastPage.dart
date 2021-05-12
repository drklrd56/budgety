import 'package:flutter/material.dart';
import '../../Models/Memory.dart';
import '../../Models/Search.dart';

class ForecastPage extends StatefulWidget {
  final _selectedAccount;
  ForecastPage(this._selectedAccount);
  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  double weekPrediction = 0;
  double monthPrediction = 0;
  double sixMonthsPrediction = 0;
  double yearPrediction = 0;
  Widget getPredictionDispaly(double amount,String message) {
    return Card(
      elevation: 3,
      child: Container(
        margin: EdgeInsets.all(5),
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
                  message,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                  ),
                ),// heading
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Divider(
              height: 2,
              color: Colors.black,
            ),
            amount != 0 && amount != null ?
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Savings',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                  ),
                ),// heading
                SizedBox(
                  width: 5,
                ),
                Text(
                  amount.toStringAsFixed(2),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ],
            ):
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                'Insufficient data for making a prediction',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getForecast() {
    List results = [];
    List<Map<String,Object>> records;
    if( accounts != null && widget._selectedAccount >= 0 && widget._selectedAccount < accounts.length) {
        results = getRecords(widget._selectedAccount,);
      records = getMonthRecords(results, widget._selectedAccount);
      weekPrediction = records[1]['Sum'];
      records = get6MonthsRecords(results, widget._selectedAccount);
      monthPrediction = records[1]['Sum'];
      records = get6MonthsRecords(results, widget._selectedAccount);
      records.removeAt(0);
      sixMonthsPrediction = 0;
      for(int index = 0; index < records.length; index++) {
        sixMonthsPrediction += records[index]['Sum'];
      }
      if(records.length > 0)
        monthPrediction = sixMonthsPrediction / records.length;
      records = get12MonthsRecords(results, widget._selectedAccount);
      records.removeAt(0);
      yearPrediction = 0;
      for(int index = 0; index < records.length; index++) {
        yearPrediction += records[index]['Sum'];
      }
      if(records.length > 0)
        yearPrediction = yearPrediction / records.length;
    }
  }
  @override
  Widget build(BuildContext context) {
    getForecast();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          getPredictionDispaly(weekPrediction, 'Based on Last Week'),
          getPredictionDispaly(monthPrediction, 'Based on Last Month'),
          getPredictionDispaly(sixMonthsPrediction, 'Based on  Last 5 Months'),
          getPredictionDispaly(yearPrediction, 'Based on this year'),
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.transparent,
            child: Text(' '),
          )
        ],  
      ),
    );
  }
}