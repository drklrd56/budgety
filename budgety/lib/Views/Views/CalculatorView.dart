import '../Views/AccountListView.dart';
import 'package:flutter/material.dart';
import '../../Models/Memory.dart';
import '../../Models/Account.dart';
import '../../Models/Record.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  int _accountSelected = 0;
  Record _newTransaction;
  final List<Function> _helperFunctions;
  CalculatorScreen(this._newTransaction, this._accountSelected, this._helperFunctions);
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String equation = "0";
  String result = "";
  String expression = "";
  int selectedType = 0;
  Color mainColor;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "";
      
      } else if (buttonText == "⌫") {
    
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "";
        }
      }
      else if(buttonText == "="){

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        Parser p = new Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      }
      else {
     
        if (equation == "0") {
          equation = buttonText;
          if(buttonText != '+' && buttonText != '-' && buttonText != '×' && buttonText != '÷') {
            result += buttonText;
          }
          else {
              result = "";
          }
        } else {
          equation = equation + buttonText;
          if(buttonText != '+' && buttonText != '-' && buttonText != '×' && buttonText != '÷') {
            result += buttonText;
          }
          else {
              result= "";
          }
        }
        
      }
      widget._newTransaction.setAmount = double.parse(result != "" ? result : "0");
      widget._helperFunctions[2](widget._newTransaction,1);
      if(buttonText == "=") result = "";
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          padding: EdgeInsets.all(16.0),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          )),
    );
  }
  
  void _changeAccount(int index) {
    setState(() {
      widget._accountSelected = index;
      widget._helperFunctions[1](index,widget._newTransaction);
    });
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    mainColor = accounts[widget._accountSelected]['viewColor'] as Color;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton (
          icon: Icon(
            Icons.arrow_back, 
            color: Colors.white,
            size: 30
          ),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              int result = widget._helperFunctions[0](widget._accountSelected,widget._newTransaction);
              if (result == 1 )
                Navigator.pop(context);
            },
          )
        ],
        elevation: 4,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
              color: mainColor,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 0.2,
                ),
              ),
            ),
            child: Row(

              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = 0;  
                      widget._newTransaction.setRecordType = 'income';
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1,
                    width: MediaQuery.of(context).size.width * 0.49,
                    color: selectedType == 0 ?  Colors.white30 : mainColor,
                    child: Center(
                      child: Text(
                        'INCOME',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ), 
                  ), 
                ),
                VerticalDivider(
                  width: 1,
                  color: Colors.black45,
                  thickness: 1,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = 1;  
                      widget._newTransaction.setRecordType = 'expense';
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1,
                    width: MediaQuery.of(context).size.width * 0.5,
                    color: selectedType == 1 ?  Colors.white30 : mainColor,
                    child: Center(
                      child: Text(
                        'EXPENSE',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ), 
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: mainColor,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: Text(
                    selectedType == 0 ? '+' : '-',
                    style: TextStyle(
                      fontSize: selectedType == 0 ? MediaQuery.of(context).size.height * 0.06 : MediaQuery.of(context).size.height * 0.08 ,
                      color: Colors.white
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        widget._newTransaction.getAmount < 1 ? '0' : widget._newTransaction.getAmount.toString() ,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          
                          fontSize: widget._newTransaction.getAmount.toString().length > 5 ? 30 : 50,
                          color: Colors.white
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                      child: Text(
                        (accounts[widget._accountSelected]['Account'] as Account).getCurrency.currencyCode,
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w300,
                          color: Colors.white
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), topLeft: Radius.circular(30)),
                        ),
                      height: MediaQuery.of(context).size.height * 0.16,
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Icon(
                        Icons.arrow_back_ios,
                      ),
                    )
                  ]
                ),
              ]
            )
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.098,
            color: mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 50),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => 
                      AccountListView(_changeAccount,viewColor:accounts[widget._accountSelected]['viewColor'])));
                    },
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Account',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white70),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          (accounts[widget._accountSelected]['Account'] as Account).getAccountName,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ]
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: null,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white70),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget._newTransaction.getCategory != null ? widget._newTransaction.getCategory : "Select Category",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ]
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("7", 0.99, Colors.white),
                      buildButton("8", 0.99, Colors.white),
                      buildButton("9", 0.99, Colors.white),
                    ]),
                    TableRow(children: [
                      buildButton("4", 0.99, Colors.white),
                      buildButton("5", 0.99, Colors.white),
                      buildButton("6", 0.99, Colors.white),
                    ]),
                    TableRow(children: [
                      buildButton("1", 0.99, Colors.white),
                      buildButton("2", 0.99, Colors.white),
                      buildButton("3", 0.99, Colors.white),
                    ]),
                    TableRow(children: [
                      buildButton(".", 0.99, Colors.white),
                      buildButton("0", 0.99, Colors.white),
                      buildButton("C", 0.99, Colors.white),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("÷", 0.8, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton("×", 0.8, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton("-", 0.8, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton("+", 0.8, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton("=", 0.8, Colors.grey),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
