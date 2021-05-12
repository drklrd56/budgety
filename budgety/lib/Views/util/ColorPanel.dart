import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class ColorPanel extends StatefulWidget {
  final Function changeColor;
  final Color primary;
  final int popType;
  ColorPanel(this.changeColor,this.primary,this.popType);
  @override
  _ColorPanelState createState() => _ColorPanelState();
}

class _ColorPanelState extends State<ColorPanel> {
  Color _mainColor;
  Color _tempMainColor;
  
  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                if(widget.popType == 1)
                  Navigator.of(context).pop();
                else 
                  Navigator.of(context, rootNavigator: true).pop('dialog');
              }
            ),
            FlatButton(
              child: Text('SELECT'),
              onPressed: () {
                setState(() {
                  _mainColor = _tempMainColor;
                  widget.changeColor(_mainColor);
                  }
                );
                if(widget.popType == 1)
                  Navigator.of(context).pop();
                else 
                  Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
          ],
        );
      },
    );
  }

  void _openMainColorPicker() async {
    _openDialog(
      "Main Color picker",
      MaterialColorPicker(
        selectedColor: _mainColor,
        allowShades: false,
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    _mainColor = widget.primary;
    return Container(
      color: _mainColor,
      width: double.infinity,
      child: OutlineButton(
        onPressed: _openMainColorPicker,
        child: const Text('Show color picker'),
      ),
    );
  }
}