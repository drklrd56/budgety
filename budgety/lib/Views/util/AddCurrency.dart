import 'package:currency_pickers/countries.dart';
import 'package:flutter/material.dart';
import 'package:currency_pickers/currency_pickers.dart';

class NewCurrency extends StatefulWidget {
  final Function _primaryFunction;
  NewCurrency(this._primaryFunction);
  @override
  _NewCurrencyState createState() => _NewCurrencyState();
}

class _NewCurrencyState extends State<NewCurrency> {
  int selectedCountry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Currency',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              widget._primaryFunction(selectedCountry);
              Navigator.pop(context);
            },
          )
          
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            child:  ListTile(
              title: Text(
              countryList[index].currencyCode+ ' - '  + countryList[index].currencyName,
              style: TextStyle(
                color : selectedCountry == index ? Colors.blue : Colors.black,
                ),
              ),
              trailing: CurrencyPickerUtils.getDefaultFlagImage(countryList[index]),
              onTap: () {
                setState(() {
                  selectedCountry = index;  
                });
                
              },
            )
          );
        }, 
        separatorBuilder: (context, index) => Divider(
            color: Colors.black,
        ),
        itemCount: countryList.length
      )
    );
  }
}