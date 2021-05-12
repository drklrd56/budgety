import 'package:budgety/Views/Views/LabelListView.dart';
import 'package:flutter/material.dart';
import '../../Models/Memory.dart';
import '../Forms/LabelForm.dart';
import '../../Models/Database.dart';

class LabelPage extends StatefulWidget {
  final Function _primaryFunction;
  final int _index;
  LabelPage(this._index,this._primaryFunction);
  @override
  _LabelPageState createState() => _LabelPageState();
}

class _LabelPageState extends State<LabelPage> {

  void _addLabel(int index,String text,Color color) async {
    final enteredTitle = text;
    if (enteredTitle.isEmpty || color == null) {
      return;
    }
    DatabaseHelper instance = DatabaseHelper.instance;
    int id = await instance.insertLabel(text,color.value.toString());
    labels.add({
      'id': id,
      'Label': text,
      'viewColor': color
    });
    Navigator.pop(context,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4acd89),
        title: Text(
          'Select Label',
          style:  TextStyle(
            color: Colors.white,
          ),
          
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings, 
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LabelListView()),
              );
            }
          ),
        ],
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
          onTap: () {
            widget._primaryFunction(widget._index,labels[index]['Label']as String);
            Navigator.pop(context);
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LabelForm(-1,[_addLabel]),)
          );
        },
      ),
    );
  }
}