import 'package:flutter/material.dart';
import '../../Models/Account.dart';
import '../../Models/Memory.dart';

class AccountListView extends StatelessWidget {
  final Function _primaryFunction;
  final Color viewColor;
  AccountListView(this._primaryFunction,{this.viewColor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: viewColor != null ? viewColor : Color(0xff4acd89),
        title: Text(
          'Account Settings'
        ),
      ),
      body: accounts.length == 0 
      ?
        Center (
          child: Text(
            'No accounts present.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
        ),
      ) 
      :
      ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          return ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: accounts[index]['viewColor'],
                ),
                child: Icon(
                  Icons.account_box,
                  color: Colors.white,
                  ),
              ),
              title: Text((accounts[index]['Account'] as Account).getAccountName,
                  style: TextStyle(fontSize: 20)),
              trailing: Icon(Icons.dehaze),
              onTap: () {
                _primaryFunction(index);
              });
        },
      )
    );
  }
}
