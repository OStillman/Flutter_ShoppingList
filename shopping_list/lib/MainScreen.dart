import 'package:flutter/material.dart';
import 'helpers/constants.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  List<String> _items = ["Apples", "Pears", "Strawberrys"];
  List<String> _currentItems = List<String>();
  List<String> _removedItems = List<String>();

  @override
  void initState() {
    _currentItems.addAll(_items);
    _currentItems.sort();
    super.initState();
  }

  void undo() {
    setState(() {
      final String item = _removedItems.last;
      _removedItems.removeLast();
      _currentItems.add(item);
      _currentItems.sort();
    });
  }

  void save() {
    setState(() {
      print(_items.toString());
      _items.clear();
      for (String item in _currentItems) {
        final bool there = _items.contains(item);
        if (!there) {
          _items.add(item);
        }
      }
      print(_items.toString());
    });
  }

  bool isSaved() {
    bool _saved = true;
    if (_items.length != _currentItems.length) {
      _saved = false;
    }
    else {
      for (String item in _currentItems) {
        if (!_items.contains(item)) {
          _saved = false;
        }
      }
    }
    return _saved;
  }

  bool canUndo() {
    if (_removedItems.length > 0) {
      return true;
    }
    else {
      return false;
    }
  }

  //To use the string it needs to be converted into a widget
  Widget _appBarTitle = new Text(appTitle);

  //We need to return a scaffold for the UI structure
  @override
  Widget build(BuildContext context) {
    if (_currentItems.length > 0 ){
      return Scaffold(
        appBar: _buildBar(context),
        body: _buildList(context),
        resizeToAvoidBottomPadding: false,
      );
    }
    else{
      return Scaffold(
        appBar: _buildBar(context),
        body: Center(
          child: Text("You have no items"),
        ),
        resizeToAvoidBottomPadding: false,
      );
    }
  }

  Widget _buildBar(BuildContext context) {
    print(canUndo());
    return new AppBar(
        backgroundColor: mainAppColor,
        title: _appBarTitle,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {
            Navigator.of(context).pushNamed(addPageTag);
          }),
          IconButton(
              icon: Icon(Icons.undo),
              color: canUndo() ? Colors.white : Colors.black,
              onPressed: canUndo() ? undo : () {}),
          IconButton(icon: Icon(Icons.save),
              color: isSaved() ? Colors.black : Colors.white,
              onPressed: save),
        ]
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children:
      this._currentItems.map((item) => _buildListItem(context, item)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, String item) {
    return ListTile(
      title: Text(
        item,
      ),
      trailing: Icon(
        Icons.remove_circle,
        color: Colors.red,
      ),
      onTap: () {
        print("Remove");
        setState(() {
          _currentItems.remove(item);
          _removedItems.add(item);
          print(_currentItems.toString());
        });
      },
    );
  }
}
