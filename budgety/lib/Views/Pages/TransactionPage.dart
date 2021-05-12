import 'package:budgety/Models/Record.dart';
import 'package:flutter/material.dart';
import '../Views/CalculatorView.dart';
import '../Forms/TransactionForm.dart';
import '../../Models/Memory.dart';
import '../../Models/Account.dart';
import '../../Models/Database.dart';

class TransactionPage extends StatefulWidget {
  final List<Color> _viewColors = [];
  final List<Map<String,Object>> _accounts;
  
  TransactionPage(this._accounts) {
    for(int index = 0; index < _accounts.length; index++) {
      _viewColors.add((_accounts[index]['viewColor'] as Color));
    }
  }
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  
  Record _newTransaction = new Record(amount: 0, category: 'Food & Drinks', recordType: 'income',
  recordDate: DateTime.now(),paymentType: 'Cash',label: ['null','null','null','null','null',]); 
  int selectedAccount = 0;

  PageController _pageController;
  
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changeAccount(int index,Record newTx) {
    setState(() {
      selectedAccount = index;
    });
  }

  void _addRecord(int accountIndex, Record record) async {
    if((accounts[accountIndex]['Transactions'] as List<Record>)== null)
        accounts[accountIndex]['Transactions'] = new List<Record>();
    setState(() {
      (accounts[accountIndex]['Transactions'] as List<Record>).add(record);
    });
    DatabaseHelper instance = DatabaseHelper.instance;
    record.setAcccountID = (accounts[accountIndex]['Account'] as Account).getAccountID;
    (accounts[accountIndex]['Transactions'] as List<Record>)[(accounts[accountIndex]['Transactions'] as List<Record>).length - 1]
    .setRecordID = await instance.insertRecord(record); 
  }
  
  int _addTransaction(int accountSelected,Record newTx) {
    if(_newTransaction.getAmount != null && _newTransaction.getAmount > 0) {
      _newTransaction.setAcccountID = (accounts[selectedAccount]['Account'] as Account).getAccountID;
      _addRecord(accountSelected, newTx);
      return 1;
    }
    return 0;
  }

  void _updateTransaction(Record newTransaction, int from) {
    setState(() {
      if(from == 1) // page 1
        _newTransaction.setAmount = newTransaction.getAmount;
      else if(from == 2)
        _newTransaction.setCategory = newTransaction.getCategory;
      else if(from == 3)
        _newTransaction.setNote = newTransaction.getNote;
      else if(from == 4)
        _newTransaction.setLabel  = newTransaction.getLabel;
      else if(from == 5)
        _newTransaction.setPayee = newTransaction.getPayee;
      else if(from == 6)
        _newTransaction.setPaymentType = newTransaction.getPaymentType;
      else if(from == 7)
        _newTransaction.setRecordDate = newTransaction.getRecordDate;
      else if(from == 9)
        _newTransaction.setRecordType = newTransaction.getRecordType;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return PageView(
      controller: _pageController,
      onPageChanged: (page) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      children: <Widget>[

        CalculatorScreen(_newTransaction, selectedAccount,[_addTransaction, _changeAccount,_updateTransaction,]),

        TransactionForm([_addTransaction,_updateTransaction],selectedAccount,selectedAccount,1,_newTransaction),
        
      ],
    );
  }
}