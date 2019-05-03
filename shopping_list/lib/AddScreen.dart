import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helpers/constants.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() {
    return _AddScreenState();
  }
}

class _AddScreenState extends State<AddScreen>{
  Widget _appBarTitle = new Text(appTitle);
  final _formKey = GlobalKey<FormState>();
  final fieldController = TextEditingController();

  _append(item) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _items = prefs.getString("items") ?? "";
    print (_items);
    final int _length = _items.length;
    if (_length > 0){
      _items += item;
    }
    else{
      _items = "$item,";
    }
    await prefs.setString("items", _items);
  }

  //We need to return a scaffold for the UI structure
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: _buildForm(context),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
        backgroundColor: mainAppColor,
        title: _appBarTitle,
    );
  }

  Widget _buildForm(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            autofocus: true,
            controller: fieldController,
            decoration: InputDecoration(
              hintText: itemHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            validator: (value){
              if (value.isEmpty){
                return "Please enter some text";
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: (){
                if (_formKey.currentState.validate()) {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      final text = fieldController.text[0].toUpperCase() + fieldController.text.substring(1);
                      return AlertDialog(
                        content: Text("Add $text?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Yes!"),
                            onPressed: (){
                              _append(text);
                            },
                          ),
                          FlatButton (
                            child: Text("No!"),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    }
                  );
                }
              },
              child: Text("Submit"),
            ),
          ),
        ]
      ),
    );
  }
}