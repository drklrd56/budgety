import 'dart:math';
import 'package:budgety/Views/Charts/SpendingPage.dart';
import 'package:flutter/material.dart';
import '../util/AppDrawer.dart';
import '../../Models/Memory.dart';
import '../../Models/Graph.dart';
import 'package:fl_chart/fl_chart.dart';
import '../Charts/CashFlowPage.dart';
import '../Charts/ReportPage.dart';
import '../AccountSettings.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../Charts/ForecastPage.dart';

import '../../Models/Account.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({ Key key, this.choice }) : super(key: key);
  final String choice;
  //build and return our card with icon and text
  
  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Colors.white,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Hello'),
          //PieChart2(0,1,2),
        ],
      ),
    );
  }
}

class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() => _GraphPageState();
}



class _GraphPageState extends State<GraphPage> {
  int _selectedAccount = 0;
  int _selectedDuration = 1;
  double cashBook_total;
  List<String> graphs = ['Forecast','Cash-Flow','Spending','Report'];
  Map<String,Object> reportData;
  List xLabels = [];
  List<double> yLabels = [];
  List<BarChartGroupData> rawBarGroups = [];
  List categoriesData = [];
  List labelsData = [];
  List<Map<String,Object>> cashBook = [];
  // void initState() {
  //   super.initState();
  //   getLabelData();
  // }
  void getData() {
    labelsData = getLabelsData(_selectedAccount, _selectedDuration);
    Map<String,Object> temp = getCategriesData(_selectedAccount, _selectedDuration);
    categoriesData = temp['1'];
    cashBook = temp['2'];
    cashBook_total = temp['3'];
    temp = getLabelData(_selectedAccount, _selectedDuration);
    xLabels = temp['1'];
    yLabels = temp['2'];
    reportData = temp['3'];
    rawBarGroups = temp['4'];
  }
  int iconType = 1;
  _changeIcon(int state) {
    if(state == 1) {
      iconType = 1;
    }
    else if (state == 2) {
      iconType = 2;
    }
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return DefaultTabController(
      length: graphs.length,
      child: Scaffold(
        drawer: HomeDrawer(),
        appBar: AppBar(
          backgroundColor: Color(0xff4acd89),
          bottom: new TabBar(
            isScrollable: true,
            tabs: graphs.map((String choice) {
              return new Tab(
                text: choice,
              );
            }).toList(),
          ),
          title: Text('Graphs'),
        ),
        body: Stack(
          children : <Widget> [
            new TabBarView(
              children: graphs.map((String choice) {
                var accountName = accounts.length > 0 && _selectedAccount < accounts.length 
                ? (accounts[_selectedAccount]['Account'] as Account).getAccountName
                : ' ';
                var accountCurrency = accounts.length > 0 && _selectedAccount < accounts.length 
                ? (accounts[_selectedAccount]['Account'] as Account).getCurrency.currencyCode
                : ' ';
                if(choice == 'Forecast')
                  return ForecastPage(_selectedAccount);
                else if(choice == 'Cash-Flow')
                  return CashFlowPage(reportData,xLabels,yLabels,rawBarGroups);
                else if(choice == 'Report')
                  return ReportPage(reportData,cashBook,cashBook_total);
                else if(choice == 'Spending')
                  return SpendingPage(categoriesData,labelsData, reportData, accountName, accountCurrency);
                return CategoryCard(choice: choice,);
                
              }).toList(),
            ),
            
            SlidingUpPanel(
              borderRadius: BorderRadius.circular(3),
              maxHeight: MediaQuery.of(context).size.height * 0.25,
              onPanelOpened: () {
                setState( () {
                  _changeIcon(2);
                });
              },
              onPanelClosed: () {
                setState((){ 
                  _changeIcon(1);
                });
              },
              panel: Column (
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  iconType == 1 ? Icon(Icons.arrow_upward) : Icon(Icons.arrow_downward),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        color: _selectedDuration == 0 ? Colors.blue :Colors.transparent,
                        onPressed: () {
                          setState(() {
                            _selectedDuration = 0;
                            getData();
                            
                          });
                        }, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          side: BorderSide(color: Colors.blue)
                        ),
                        child: Text('7D',
                          style: TextStyle(
                            fontSize: 18,
                            color: _selectedDuration == 0 ? Colors.white : Colors.blue,
                          ),
                        ),
                      ),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue)
                        ),
                        color: _selectedDuration == 1 ? Colors.blue :Colors.transparent,
                        onPressed: () {
                          setState(() {
                            _selectedDuration = 1;
                            getData();
                          });
                        },
                        child: Text('1M',
                          style: TextStyle(
                            fontSize: 18,
                            color: _selectedDuration == 1 ? Colors.white : Colors.blue,
                          ),
                        ),
                      ),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue)
                        ),
                        color: _selectedDuration == 2 ? Colors.blue :Colors.transparent,
                        onPressed: () {
                          setState(() {
                            _selectedDuration = 2;
                            getData();
                          });
                        },
                        child: Text('6M',
                          style: TextStyle(
                            fontSize: 18,
                            color: _selectedDuration == 2 ? Colors.white : Colors.blue,
                          ),
                        ),
                      ),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          side: BorderSide(color: Colors.blue)
                        ),
                        color: _selectedDuration == 3 ? Colors.blue :Colors.transparent,
                        onPressed: () {
                          setState(() {
                            _selectedDuration = 3;
                            getData();
                          });
                        }, 
                        child: Text('1Y',
                          style: TextStyle(
                            fontSize: 18,
                            color: _selectedDuration == 3 ? Colors.white : Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:  MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: DropdownButtonHideUnderline(
                          child:DropdownButton<int>(
                            hint:  Text("Select Account"),
                            
                            value:  _selectedAccount,

                            onChanged: (int value) {
                              setState(() {
                                _selectedAccount = value;
                                getData();
                              });
                            },
                            items: (accounts).asMap().entries.map(
                              (account) {
                                return DropdownMenuItem<int> ( 
                                  value: account.key,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Text((account.value['Account'] as Account).getAccountName),
                                    ],
                                  ),
                                );
                              }
                            ).toList(),
                          )
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      IconButton(                   
                        icon: Icon(
                          Icons.settings,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSetting(null,)));
                        }
                      ),
                    ],
                  )
                ] 
              ),
            ),
          ]
        ),
      ),
    );
  }

  

}