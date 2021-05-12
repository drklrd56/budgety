import 'package:flutter/material.dart';
import './Forms/AccountForm.dart';
import './Views/AccountListView.dart';
import '../Models/Memory.dart';
import '../Models/Account.dart';
import '../Models/Database.dart';

class AccountSetting extends StatefulWidget {
  final Function _helperFunction;
  AccountSetting(this._helperFunction);
  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  
  void _removeAccount(int accountIndex) async {
    int newIndex = accounts.length -1;
    if (newIndex < 0)
      newIndex = 0;
    int id = (accounts[accountIndex]['Account'] as Account).getAccountID;
    setState(() {
      accounts.removeAt(accountIndex);
      if(widget._helperFunction != null)
        widget._helperFunction(newIndex);
    });
    DatabaseHelper instance = DatabaseHelper.instance;
    await instance.deleteAccount(id);
    //await instance.deleteAll();
  }

  void _editAccount(Account editAccount,Color viewColor,int accountIndex) async {
    DatabaseHelper instance = DatabaseHelper.instance;
    setState(() {
      accounts[accountIndex]['Account'] = editAccount;
      accounts[accountIndex]['viewColor'] = viewColor;
    });
    await instance.updateAccount(editAccount, viewColor);
  }

  _navigateToAccountSettings( int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountForm([_editAccount,_removeAccount],index,2) 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AccountListView(_navigateToAccountSettings);
  }
}