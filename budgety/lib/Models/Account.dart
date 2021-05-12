
import 'package:currency_pickers/country.dart';
import 'package:flutter/material.dart';
class Account {
  int _accountID;
  String _accountName;
  Country _currency;
  double _amount;
  DateTime _creationTime;
  Account({int accountID = null,String accountName='',Country currency,double amount=0.0,DateTime creationTime}) {
    this._accountName = accountName;
    this._amount = amount;
    this._currency = currency;
    this._accountID =accountID;
    this._creationTime = creationTime;
  }

  factory Account.fromMap(Map<String, dynamic> data) {
    var workAround = (data['Currency'] as String).split(',');
    return Account( 
      accountID: data['AccountID'], 
      creationTime: DateTime.parse(data['CreationTime']),
      accountName: data['AccountName'], 
      currency: Country(currencyCode: workAround[0],currencyName: workAround[1],iso3Code: workAround[2],isoCode: workAround[3],name: workAround[4]), 
      amount: data['Amount'], 
    ); 
  } 

  Map<String, dynamic> toMap(Color viewColor) {
    var map = <String,dynamic> {
      "AccountName": _accountName,
      "Amount": _amount,
      "CreationTime": _creationTime.toString(),
      "Currency": ([_currency.currencyCode,_currency.currencyName,_currency.iso3Code,_currency.isoCode,_currency.name].join(',')).toString(),
      "ViewColor": viewColor.value.toString()
    };
    if(_accountID != null) {
      map["accountID"] = _accountID; 
    }
    return map;
  }

  void display() {
    print(_accountID);
    print(_accountName);
    print(_amount);
    print(_creationTime);
    print(_currency.currencyCode);
    print(_currency.currencyName);
  }
  
  int get getAccountID => _accountID;

  set setAccountID(int value) => _accountID = value;

  String get getAccountName => _accountName;

  Country get getCurrency => _currency;

  double get getAmount => _amount;
  
  set setAccountName(String _accountName) => this._accountName = _accountName;

  set setCurrency(Country _currency) => this._currency = _currency;
  
  set setAmount(double _amount) => this._amount = _amount;

  DateTime get getCreationTime => _creationTime;

  set setCreationTime(DateTime time) => _creationTime = time;

}