import 'package:currency_pickers/countries.dart';
import 'package:currency_pickers/country.dart';

List<Country> availableContries = [countryList[0],countryList[1],];
List<Map<String,Object>> accounts = [];
List<Map<String,Object>> labels = [];
List<String> paymentTypes = [
    'Cash',
    'Debit Card',
    'Credit Card',
    'Bank Transfer',
    'Mobile Payment',
    'Web Payment'
  ];
  List<String> categories = [
    'Food & Drinks',
    'Shopping',
    'Housing',
    'Transportation',
    'Vehicle',
    'Life & Entertainment',
    'Communication & PC',
    'Investments',
    'Income',
    'Others'
  ];