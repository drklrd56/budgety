import 'package:flutter/material.dart';
import '../../Models/Record.dart';
import 'package:intl/intl.dart';

class TransactionView extends StatelessWidget {
  final Record transaction;
  final String accountName;
  final String currencyAccount;
  TransactionView(this.transaction,this.accountName,this.currencyAccount);
  Container getNote(BuildContext context) {
    String note = transaction.getNote;
    if(note != null) {
      if(note.length > 0 )
        return Container (
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            note,
            textWidthBasis: TextWidthBasis.longestLine,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(

              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w300,
            ),
          ),
        );
    }
    return Container( child: Text(" "));
  }
   Row getPayee() {
    if(transaction.getPayee != null) 
      return Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Text(transaction.getPayee),
        ],
      );
    else
      return Row(
        children: <Widget>[
          SizedBox(
            width: 0,
          ),
        ],
      );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              
              children: <Widget>[

                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.account_balance
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        transaction.getCategory,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: Text(
                          transaction.getRecordType == 'expense' ?
                          '-'+currencyAccount + transaction.getAmount.toString() :
                          '+'+currencyAccount + transaction.getAmount.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: transaction.getRecordType == 'expense' ? Colors.red : Color(0xff4acd89),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(    
                  children: <Widget>[
                    
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        accountName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        DateFormat.yMd() .format(transaction.getRecordDate),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                //getPayee(),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    getNote(context),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Wrap(
                        children: <Widget>[
                          ...transaction.getLabel.asMap().entries.map((label) {
                            return  label.value != null && label.value != 'null'
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                                height: MediaQuery.of(context).size.width * 0.06,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      label.value,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                  ],
                                ),
                            ) : SizedBox(width: 0);
                          })
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}