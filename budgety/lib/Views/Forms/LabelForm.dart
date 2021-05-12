import 'package:flutter/material.dart';
import '../../Models/Memory.dart';
import '../util/ColorPanel.dart';

class LabelForm extends StatefulWidget {
  final int _labelIndex;
  final List<Function> _primaryFunctions;
  LabelForm(this._labelIndex,this._primaryFunctions);
  @override
  _LabelFormState createState() => _LabelFormState();
}

class _LabelFormState extends State<LabelForm> {
  Color _color;
  void _changeColor(Color color) {
    setState(() {
      _color = color;
    });
  }
  final titleController = TextEditingController();
  
  

  void initState() {
    super.initState();
    _color = widget._labelIndex == -1 ? Colors.blue : labels[widget._labelIndex]['viewColor'];
    titleController.text = widget._labelIndex == -1 ? null : labels[widget._labelIndex]['Label'];
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4acd89),
        title: Text('Add Label'),
        actions: <Widget>[
          widget._labelIndex != -1 ?
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
              size: MediaQuery.of(context).size.height * 0.04 ,
            ), 
            onPressed: () {
              widget._primaryFunctions[1](widget._labelIndex);
            },
          ): SizedBox( width: 0),
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
              size: MediaQuery.of(context).size.height * 0.04 ,
            ), 
            onPressed: () {
              widget._primaryFunctions[0](widget._labelIndex,titleController.text,_color);
            },
          ),
        ],
      ),
      body: Card(
        elevation: 4,
        child: Form(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: titleController,
                  autocorrect: false,
                  maxLength: 10,
                ),
                SizedBox(
                  height: 60,
                ),
                ColorPanel(_changeColor,_color,1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
