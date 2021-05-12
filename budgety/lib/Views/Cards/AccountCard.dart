import 'package:flutter/material.dart';
import '../AccountSettings.dart';
import '../Views/AccountView.dart';
import '../Forms/AccountForm.dart';
import '../../Models/Account.dart';
import '../../Models/Database.dart';
import '../../Models/Memory.dart';

class AccountCard extends StatefulWidget {

  final BuildContext _secondaryContext;
  final List<AccountView> _accountView = [];
  final Function _helperFunction;
  
  AccountCard(this._secondaryContext,List<Map<String,Object>> accounts,this._helperFunction) {
    for(int i = 0; i < accounts.length ; i++) {
      _accountView.add(AccountView(accounts[i]));
    }
  }
  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  
  void _addAccount(Account newAccount,Color viewColor,int accountIndex) async {
    
    DatabaseHelper instance = DatabaseHelper.instance;
    setState(() {
      accounts.add({
        'Account': newAccount,
        'viewColor': viewColor
      });  
    });

    widget._helperFunction(accountIndex);
    int id = await instance.insertAccount(newAccount, viewColor);
    (accounts[accounts.length -1 ]['Account'] as Account).setAccountID = id;
  }

  void _navigateAndDisplaySelection(BuildContext context,) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountForm([_addAccount], -1,1)),
    );
  }

  void _settings(BuildContext context){ 
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountSetting(widget._helperFunction)),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Card (
      elevation: 2,

      child: Container (
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                Text(
                  'List of Accounts',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Container(
                  child:IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _settings(widget._secondaryContext);
                    }
                  )
                ),
              ],
            ),
            SizedBox(height:15),
            Wrap (
              runSpacing: 5,
              
              children:<Widget> [   
                accounts.isEmpty 
              ?
                Center(
                  heightFactor: 3,
                  child: Text(
                    'Add an account',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                )
              : 
              Text(''),
              ...widget._accountView.asMap().entries.map((view) {
                  return new GestureDetector(
                    onTap: () {
                      widget._helperFunction(view.key);
                    },
                    child: view.value,
                  );
                },
              ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget> [
                RaisedButton (
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    'Add Account',
                    style: TextStyle(
                      fontSize: 20
                    )
                  ),
                  onPressed: () {
                    _navigateAndDisplaySelection(widget._secondaryContext,);
                  }
                ),
              ],
            ),
          ],
        )
      )
    );
  }
}