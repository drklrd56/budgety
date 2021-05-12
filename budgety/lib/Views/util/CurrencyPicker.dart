import 'package:flutter/material.dart';
import 'package:currency_pickers/currency_pickers.dart';
import 'package:currency_pickers/country.dart';
import 'package:currency_pickers/countries.dart';
import "./AddCurrency.dart";
import '../../Models/Memory.dart';

class CurrencyPicker extends StatefulWidget {
  final Function changeCountry;
  Country selectedCountry = availableContries[0];
  CurrencyPicker(this.changeCountry,{this.selectedCountry});
  @override
  _CurrencyPickerState createState() => _CurrencyPickerState();
}

class _CurrencyPickerState extends State<CurrencyPicker> {
  
  void _primaryFunction(int index) {
    if(index > 0 && index < countryList.length)
      if(availableContries.contains(countryList[index]) != true)
        availableContries.add(countryList[index]);
  }

  void _addCurrencyButton() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewCurrency(_primaryFunction)));
  }

  DropdownMenuItem<Country> _buildDropdownItemCountries(Country country) {
    return  DropdownMenuItem<Country> ( 
      value: country,
      child: Row(
        children: <Widget>[
          CurrencyPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8.0,
          ),
          Text("+${country.currencyCode}(${country.isoCode})"),
        ],
      ),
    );
  }
  int loc = -1;  
  @override
  Widget build(BuildContext context) {
    if(widget.selectedCountry != null) {
      loc = availableContries.indexWhere((item) => item.name == widget.selectedCountry.name);
      if(loc == -1 ) {
        availableContries.add(widget.selectedCountry);
        loc = availableContries.length - 1;
      }
    }
    return Container(
      width: double.infinity,
      child: Column ( 
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: DropdownButtonHideUnderline(
              child:DropdownButton<Country>(
                hint:  Text("Select Currency"),
                
                value: loc != -1 ? availableContries[loc] : availableContries[0],

                onChanged: (Country value) {
                  setState(() {
                    widget.selectedCountry = value;
                    widget.changeCountry(widget.selectedCountry);
                  });
                },
                items: availableContries.map(
                  (country) {
                    return _buildDropdownItemCountries(country);
                  }
                ).toList(),
              )
            )
          ),
          SizedBox(height: 4),
          FlatButton(
            onPressed: () { _addCurrencyButton();},
            child: Text(
              'ADD CURRENCY',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 17
              ),
            ),
          )
        ]
      ),
    );
  }
}