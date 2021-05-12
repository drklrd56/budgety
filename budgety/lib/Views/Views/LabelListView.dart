import 'package:flutter/material.dart';
import "../../Models/Memory.dart";
import "../../Models/DataBase.dart";
import '../Forms/LabelForm.dart';
import "../../Models/Record.dart";

class LabelListView extends StatefulWidget {
  @override
  _LabelListViewState createState() => _LabelListViewState();
}

class _LabelListViewState extends State<LabelListView> {

  void updateAccounts(int type,String label,{String old}) async {
    for(int index =0; index < accounts.length; index++) {
      for(int i = 0; i < (accounts[index]['Transactions'] as List<Record>).length; i++)
        if(type == 1)
          (accounts[index]['Transactions'] as List<Record>)[i].getLabel.removeWhere( (item) => item == label);
        else if(type == 2) {
          int loc = (accounts[index]['Transactions'] as List<Record>)[i].getLabel.indexWhere( (item) => item == old);
          if(loc != -1 )
            (accounts[index]['Transactions'] as List<Record>)[i].setSingleLabel(loc, label);
        }
    }
  }

  void _editLabel(int index,String text,Color color) async {
    String old = labels[index]['Label'];
    setState( () {
      labels[index]['Label'] = text;
      labels[index]['viewColor'] = color;
    });
    
    DatabaseHelper instance = DatabaseHelper.instance;
    await instance.updateLabel(labels[index]['id'],text,color.value.toString());
    Navigator.pop(context,);
    updateAccounts(2,text,old:old);
  }

  void _deleteLabel(int index) async {
    int id = labels[index]['id'];
    String text = labels[index]['Label'];
    setState( () {
      labels.removeAt(index);
    });
    DatabaseHelper instance = DatabaseHelper.instance;
    await instance.deleteLabel(id);
    Navigator.pop(context,);
    updateAccounts(1,text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Label'),
      ),
      body: labels.length > 0 ? 
      ListView.separated(
        separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
      itemCount: labels.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: labels[index]['viewColor'],
            ),
          ),
          title: Text(
            labels[index]['Label']as String,
            style: TextStyle(fontSize: 20)
          ),
          trailing: Icon(Icons.dehaze),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LabelForm(index,[_editLabel,_deleteLabel]),
              )
            );
          },
        );
        }
      )
      :
      Center(
        child: Text(
          'Add Labels'
        ),
      ),
    );
  }
}