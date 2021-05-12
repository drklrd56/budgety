import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../Models/Search.dart';
import '../../Models/Memory.dart';
import '../../Models/Account.dart';
import '../../Models/Record.dart';
import '../AccountSettings.dart';
import '../util/AppDrawer.dart';
import '../Views/TransactionListView.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  final int _selectedAccount;
  SearchPage(this._selectedAccount);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int selectedAccount;
  int showTitle = 1;
  int selectedDuration = 0;
  int changeIcon;
  List<Map<String,Object>> _searchResults = [];
  List results;
  List<String> months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
  void _searchRecords(String property) {
    if(accounts.length > 0) {
      results = getRecords(selectedAccount, property: property);
      if(selectedDuration == 0)
        _searchResults = getWeekRecords(results, selectedAccount);
      else if(selectedDuration == 1)
        _searchResults = getMonthRecords(results, selectedAccount);
      else if(selectedDuration == 2)
        _searchResults = get6MonthsRecords(results, selectedAccount);
      else if(selectedDuration == 3)
        _searchResults = getYearRecords(results, selectedAccount);
    }
  }
  void _initRecords() {
    if(accounts.length > 0) {
      results = getRecords(selectedAccount);
      if(selectedDuration == 0)
        _searchResults = getWeekRecords(results, selectedAccount);
      else if(selectedDuration == 1)
        _searchResults = getMonthRecords(results, selectedAccount);
      else if(selectedDuration == 2)
        _searchResults = get6MonthsRecords(results, selectedAccount);
      else if(selectedDuration == 3)
        _searchResults = getYearRecords(results, selectedAccount);
    }
  }

  void initState() {
    super.initState();
    selectedAccount = widget._selectedAccount;
    selectedDuration = 0;
    changeIcon = selectedAccount;
    _initRecords();  
  }

  Container _clusterBox(Map<String,Object> results) {
    if((results['Indices'] as List).length > 0 && accounts.length > 0) {
      List<Record> temp = [];
      for(int index = 0 ; index < (results['Indices'] as List).length; index++) {
        temp.add((accounts[selectedAccount]['Transactions'] as List<Record>)[(results['Indices'] as List)[index]]);
      }
      Map<String,Object> argument = {
        'Account': accounts[selectedAccount]['Account'],
        'Transactions': temp,
      };
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child : Text(
                          selectedDuration == 0 ? temp[0].getRecordDate.day == DateTime.now().day ? 'TODAY' 
                          : DateFormat.yMd() .format(temp[0].getRecordDate).toString() :
                          selectedDuration == 1 ? months[temp[0].getRecordDate.month -1] :
                          selectedDuration == 2 ? months[temp[0].getRecordDate.month -1] : DateFormat.y().format(temp[0].getRecordDate),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          'Balance ' + ((accounts[selectedAccount]['Account'] as Account).getAmount + (results['Sum'] as double)).toString(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )       
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          (accounts[selectedAccount]['Account'] as Account).getCurrency.currencyCode + ' ' + (results['Sum'] as double).toString(),
                        )
                      )
                    ],
                  ),
                  
                ],
              ),
            ),
            TransactionListView(argument, selectedAccount),
          ],
        ),
      );
    }
    else 
     return Container(
       child: SizedBox(
         width: 0,
       )
     );
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
    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xff4acd89),
        title: showTitle ==1 ? Text('Records')
        : TextField(
          style: TextStyle(
            color: Colors.white,
          ),
          onChanged: (String value) {
            setState( () {
              _searchRecords(value);
            });
          },
          decoration: new InputDecoration(
            hintText: 'Search in Records',
            fillColor: Colors.white,
          ),
          autocorrect: false,

        ),
        actions: <Widget>[
          showTitle == 1
          ?
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState((){
                showTitle = 0;
              });
            }
          )
          :
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState((){
                showTitle = 1;
              });
            }
          ),
        ],
      ),
      body: Stack(
        children : <Widget> [
          _searchResults.length > 0 ?
          ListView.builder(
            itemBuilder: (context, index) {
              return _clusterBox(_searchResults[index]);
            },
            itemCount: _searchResults.length
          ): Center(child: Text('No records found')),
          
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
                      color: selectedDuration == 0 ? Colors.blue :Colors.transparent,
                      onPressed: () {
                        setState(() {
                          selectedDuration = 0;
                          if(accounts.length > 0)
                            _searchResults = getWeekRecords(results, selectedAccount);
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
                          color: selectedDuration == 0 ? Colors.white : Colors.blue,
                        ),
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue)
                      ),
                      color: selectedDuration == 1 ? Colors.blue :Colors.transparent,
                      onPressed: () {
                        setState(() {
                          selectedDuration = 1;
                          if(accounts.length > 0)
                            _searchResults = getMonthRecords(results, selectedAccount);
                        });
                      },
                      child: Text('1M',
                        style: TextStyle(
                          fontSize: 18,
                          color: selectedDuration == 1 ? Colors.white : Colors.blue,
                        ),
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue)
                      ),
                      color: selectedDuration == 2 ? Colors.blue :Colors.transparent,
                      onPressed: () {
                        setState(() {
                          selectedDuration = 2;
                          if(accounts.length > 0)
                            _searchResults = get6MonthsRecords(results, selectedAccount);
                        });
                      },
                      child: Text('6M',
                        style: TextStyle(
                          fontSize: 18,
                          color: selectedDuration == 2 ? Colors.white : Colors.blue,
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
                      color: selectedDuration == 3 ? Colors.blue :Colors.transparent,
                      onPressed: () {
                        setState(() {
                          selectedDuration = 3;
                          if(accounts.length > 0)
                            _searchResults = getYearRecords(results, selectedAccount);
                        });
                      }, 
                      child: Text('1Y',
                        style: TextStyle(
                          fontSize: 18,
                          color: selectedDuration == 3 ? Colors.white : Colors.blue,
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
                          
                          value:  selectedAccount,

                          onChanged: (int value) {
                            setState(() {
                              selectedAccount = value;
                              if(accounts.length > 0) {
                                results = getRecords(value);
                                if(selectedDuration == 0)
                                  _searchResults = getWeekRecords(results, value);
                                else if(selectedDuration == 1)
                                  _searchResults = getMonthRecords(results, value);
                                else if(selectedDuration == 2)
                                  _searchResults = get6MonthsRecords(results, value);
                                else if(selectedDuration == 3)
                                  _searchResults = getYearRecords(results, value);
                              }
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
        ],
      ),
    );
  }
}