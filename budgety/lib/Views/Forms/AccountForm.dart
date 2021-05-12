import 'package:budgety/Models/Memory.dart';

import '../util/CurrencyPicker.dart';
import '../util/ColorPanel.dart';
import 'package:flutter/material.dart';
import 'package:currency_pickers/country.dart';
import '../../Models/Account.dart';

class AccountForm extends StatefulWidget {
  final List<Function> _primaryFunction;
  final int _accountIndex;
  final int formType;
  AccountForm(this._primaryFunction,this._accountIndex,this.formType);

  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  
  int settingChange = 0;
  Account account;
  Color viewColor = Colors.blue;
  int accountIndex;

  void initState() {
    super.initState();
    if(widget._accountIndex != -1) {
      accountIndex = widget._accountIndex;
      account = accounts[accountIndex]['Account'] as Account;
      viewColor = accounts[accountIndex]['viewColor'] as Color;
    }
    else {
      account = new Account();
      accountIndex = 0;
    }
  }

  

  void _changeColor(Color color) {
    setState(() {
      viewColor = color;
    });
  }

  void _changeCurrency(Country country) {
    setState(() {
      account.setCurrency = country;
    });
  }

  String _setInitial(int type) {
      if(accountIndex != -1)
        if(type == 1)
          return account.getAccountName;
        if(type == 2)
          return account.getAmount.toString();
        if(type == 3)
          return account.getCurrency.toString();
        if(type == 4)
          return viewColor.toString();
      else 
        return '';
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4acd89),
        title: Text('Add Account'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done
            ), 
            onPressed: () {
              if (_formKey.currentState.validate()) {
                if(account.getCurrency == null)
                  account.setCurrency = availableContries[0];
                account.setCreationTime = DateTime.now(); 
                widget._primaryFunction[0](account,viewColor,accountIndex);
                Navigator.pop(context,account);
                
              }
            }
          ),
          widget.formType == 2 
          ? IconButton(
            icon: Icon(Icons.delete), 
            onPressed: () {
              widget._primaryFunction[1](accountIndex);
              Navigator.pop(context);
            }
          ) 
          : SizedBox(width:0),
        ],
      ),
      body: SingleChildScrollView(
        child: Container (
          padding: EdgeInsets.all(20),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[ 
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Account Name',
                      ),
                      initialValue: _setInitial(1),
                      maxLength: 15,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text.';
                        }
                        if(value.length > 15) 
                          return 'Account Name exceeds max length.';
                        account.setAccountName = value;
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount'
                      ),
                      maxLength: 17,
                      initialValue: _setInitial(2),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if(value.contains(new RegExp(r'[A-Z]')) || value.contains(new RegExp(r'[a-z]'))) {
                          return 'Text can\'t be used as amount';
                        }
                        account.setAmount = double.parse(value);
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    CurrencyPicker(_changeCurrency,selectedCountry: account.getCurrency,),
                    SizedBox(height: 40),
                    accountIndex == 1
                    ? 

                    ColorPanel(_changeColor,viewColor,1)
                    :
                    ColorPanel(_changeColor,viewColor,2),
                    SizedBox(height: 50),
                  ]
                ) 
              ),
            ]
          )
        )
      )
    );
  }
}


