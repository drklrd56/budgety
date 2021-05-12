
import 'package:flutter/material.dart';
import '../../Models/Record.dart';
import '../../Models//Memory.dart';
import '../util/DateTimePicker.dart';
import '../Pages/LabelPage.dart';

class TransactionForm extends StatefulWidget {
  final List<Function> _primaryFunctions;
  final int _transactionIndex;
  final int _accountIndex;
  final int _formType;
  final Record tempRecord;
  TransactionForm(this._primaryFunctions,this._transactionIndex,this._accountIndex,this._formType,this.tempRecord);
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  Record newTransaction;
  void initState() {
    super.initState();
    newTransaction = widget.tempRecord;
  }
  DropdownMenuItem<String> _buildDropdownItemPaymentType(String paymentType) {
    return DropdownMenuItem<String>(
      value: paymentType,
      child: Row(
        children: <Widget>[
          Text(paymentType),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
  void _addLabel(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LabelPage(index,(int index,String label) {
        newTransaction.setSingleLabel(index, label);
        }),
      )
    );
  }
  
  FlatButton labelButton({String labelText = "Add Label",int labelIndex = 0}) {
    return FlatButton(
      onPressed: () {
        _addLabel(labelIndex);
        if(widget._formType ==1)
          widget._primaryFunctions[1](newTransaction, 4);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              labelText,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 2),
            labelText == "Add Label" ? 
            Icon(
              Icons.add_circle,
              color: Colors.blueAccent,
            )
            :
            GestureDetector(
              child: Icon(
                Icons.remove_circle,
                color: Colors.blueAccent,
              ),
              onTap: () {
                setState( () {
                  newTransaction.removeLabel(labelIndex);
                  if(widget._formType == 1)
                    widget._primaryFunctions[1](newTransaction, 4);
                });
              },
            )
          ],
        )
      ),
    );
  }

  void _selectDate(DateTime date) => 
    setState(() {
      newTransaction.setRecordDate = date;
      if(widget._formType == 1)
        widget._primaryFunctions[2](newTransaction,7);
      else
        widget._primaryFunctions[0](widget._transactionIndex,newTransaction);
    });

  void _selectTime(TimeOfDay date) => 
    setState(() {
      newTransaction.setRecordDate = new DateTime(newTransaction.getRecordDate.year,newTransaction.getRecordDate.month,
      newTransaction.getRecordDate.day,date.hour,date.minute);
      if(widget._formType == 1)
        widget._primaryFunctions[2](newTransaction,7);
      else
        widget._primaryFunctions[0](widget._transactionIndex,newTransaction);
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          backgroundColor: widget._accountIndex != -1 && widget._accountIndex < accounts.length ? accounts[widget._accountIndex]['viewColor'] : Color(0xff4acd89),

          actions: <Widget>[
            widget._formType != 1
            ? IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget._primaryFunctions[1](widget._transactionIndex,);
                  Navigator.pop(context);
                })
            : SizedBox(width: 0,),
            IconButton(
              icon: Icon(
                Icons.done,
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  widget._primaryFunctions[0](widget._transactionIndex,newTransaction);
                  Navigator.of(context).pop();
                }
              }
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              widget._formType == 2 
              ? Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 1.0, // soften the 
                      )
                    ],
                    color: Colors.grey[300],
                  ),
                  height: MediaQuery.of(context).size.height * 0.08,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                        newTransaction.setRecordType = 'income';
                          });
                          if(widget._formType == 1) 
                            widget._primaryFunctions[1](newTransaction,9);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 1,
                          width: MediaQuery.of(context).size.width * 0.491,
                          color: newTransaction.getRecordType == 'income' ?  Color(0xff4acd89) : Colors.grey,
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
                        newTransaction.setRecordType = 'expense'; 
                          });
                          if(widget._formType == 1) 
                            widget._primaryFunctions[1](newTransaction,9);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 1,
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: newTransaction.getRecordType == 'expense' ?  Color(0xff4acd89) : Colors.grey,
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
                ) : SizedBox(width: 0,),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Category',
                                ),
                                hint: Text("Select Category"),
                                value: newTransaction.getCategory, 
                                onChanged: (String value) {
                                  setState(() {
                                    newTransaction.setCategory = value;
                                    if(widget._formType == 1)
                                      widget._primaryFunctions[1](newTransaction,2);
                                    else
                                      widget._primaryFunctions[0](widget._transactionIndex,newTransaction);
                                  });
                                },
                                items: categories.map((category) {
                                  return _buildDropdownItemPaymentType(category);
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Amount',
                            ),
                            maxLength: 17,
                            keyboardType: TextInputType.numberWithOptions(),
                            initialValue: newTransaction.getAmount == null
                                ? "0"
                                : newTransaction.getAmount.toString(),
                            onChanged: (value) {
                              if(value.contains(new RegExp(r'[A-Z]')) == false &&
                                value.contains(new RegExp(r'[a-z]')) == false) {
                            newTransaction.setAmount = double.parse(value);
                                if(widget._formType == 1)
                                  widget._primaryFunctions[1](newTransaction,1);
                                else 
                                  widget._primaryFunctions[0](widget._transactionIndex,newTransaction);
                              }
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if(value.contains(new RegExp(r'[A-Z]')) || value.contains(new RegExp(r'[a-z]'))) {
                                return 'Please only enter numbers';
                              }
                              newTransaction.setAmount = double.parse(value);
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Note',
                            ),
                            autocorrect: false,
                            initialValue: newTransaction.getNote.length < 1
                                ? ""
                                : newTransaction.getNote,
                            onChanged: (value) {
                          newTransaction.setNote = value;
                              if(widget._formType == 1) 
                                widget._primaryFunctions[1](newTransaction,3);
                              else
                                widget._primaryFunctions[0](widget._transactionIndex,newTransaction);
                            },
                            validator: (value) {

                          newTransaction.setNote = value;
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Labels',
                            style: TextStyle(
                                color: Color(0xff4acd89),
                                fontWeight: FontWeight.w400),
                          ),     
                          Wrap(
                            children: <Widget>[
                              ...newTransaction.getLabel
                                  .asMap()
                                  .entries
                                  .map((label) {
                                if(label.key > 0 && newTransaction.getLabel[label.key -1] == 'null')
                                  return SizedBox(width: 0,);
                                else if (label.value != null && label.value != 'null')
                                  return labelButton(labelText: label.value,labelIndex: label.key);
                                else {
                                  return labelButton(labelIndex: label.key);
                                }
                              }),
                            ],
                          ),

                          Divider(
                            color: Color(0xff4acd89),
                            thickness: 2,
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Payee',
                            ),
                            initialValue:
                            newTransaction.getPayee.length < 1
                                    ? ""
                                    : newTransaction.getPayee,
                            onChanged: (value) {
                          newTransaction.setPayee = value;
                              if(widget._formType == 1)
                                widget._primaryFunctions[1](newTransaction,5);
                              else
                                widget._primaryFunctions[0](widget._transactionIndex,newTransaction);
                            },
                            validator: (value) {
                            newTransaction.setPayee = value;
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          DateTimePicker(
                            labelText: 'Date & Time',
                            selectedDate:
                            newTransaction.getRecordDate,
                            selectedTime:
                                TimeOfDay.fromDateTime(newTransaction.getRecordDate),
                            selectDate: _selectDate,
                            selectTime: _selectTime,
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'PaymentType',
                                ),
                                hint: Text("Select Payment Type"),
                                value: newTransaction.getPaymentType,
                                onChanged: (String value) {
                                  setState(() {
                                    newTransaction.setPaymentType = value;
                                    if(widget._formType == 1) 
                                      widget._primaryFunctions[1](newTransaction,6);
                                    else
                                      widget._primaryFunctions[0](widget._transactionIndex,newTransaction);
                                  });
                                  
                                },
                                items: paymentTypes.map((paymentType) {
                                  return _buildDropdownItemPaymentType(
                                      paymentType);
                                }).toList(),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 0.3,
                          ),
                          SizedBox(height: 100),
                        ],
                      ),
                    )
                  ]
                )
              )
          ]
        )
      ) 
    );
  }
}
