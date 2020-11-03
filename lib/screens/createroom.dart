import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utility/database/model.dart';
import '../utility/database/database_helper.dart';
import 'troom.dart';

import '../global.dart';

class createroom extends StatefulWidget {
  @override
  _createroomState createState() => _createroomState();
}

class _createroomState extends State<createroom> {
  global g = new global();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: /*Center(
        child: Text("${global.pnumber}"),
      ),*/
          FormScreen(),
    );
  }
}

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  String _rname;
  String _rtime;
  String _rlimit;
  String _rrepeat;
  String _rid;

  troom t = new troom();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void insertdata() async {
    Map<String, dynamic> row = {
      DatabaseHelper.rname: _rname,
      DatabaseHelper.rlimit: _rlimit,
    };
    final id = await dbHelper.insert(row);
    print(id);
    queryall();
  }

  void delete() async {
    var id = await dbHelper.deletedata(3);
  }

  void queryall() async {
    var allrows = await dbHelper.queryall();
    int i = allrows.length;
    allrows.forEach((element) {
      print(element);
    });
  }

  Widget _buildrNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      keyboardType: TextInputType.text,
      onSaved: (String value) {
        _rname = value;
        print("$_rname");
      },
      validator: (String value) {
        if (value.isEmpty) {
          return 'Room name cannot be empty';
        }
        if (!RegExp(r'(^[a-zA-Z ]*$)').hasMatch(value)) {
          return 'PLease enter a valid room name';
        }
      },
    );
  }

  Widget _buildrrepeat() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Repeat'),
      onSaved: (String value) {
        _rrepeat = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return 'Room repeat cannot be empty';
        }
        if (!RegExp(r'(^[a-zA-Z ]*$)').hasMatch(value)) {
          return 'PLease enter a valid Repeat name';
        }
      },
    );
  }

  Widget _buildrtime() {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(labelText: 'Time'),
      onSaved: (String value) {
        _rtime = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return 'Time cannot be empty';
        }
        int calories = int.tryParse(value);

        if (calories == null || calories <= 0) {
          return 'Cannot be 0 or anything apart from natural number';
        }
        /* Pattern pattern =
            r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(value))
          return 'Enter Valid Phone Number';
        else
          return null;*/
        /*if(!RegExp('/^(\+\d{1,3}[- ]?)?\d{10}$/').hasMatch(value)){
              return ;
        }*/
      },
    );
  }

  void _save() async {
    // moveToLastScreen();

    //note.date = DateFormat.yMMMd().format(DateTime.now());
  }

  Widget _buildrlimit() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Limit'),
      onSaved: (String value) {
        _rlimit = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return 'Room limit cannot be empty';
        }
        int calories = int.tryParse(value);

        if (calories == null || calories <= 0) {
          return 'Cannot be 0';
        }
        /*Pattern pattern =
            r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(value))
          return 'Enter Valid Limit Number';
        else
          return null;*/
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _buildrNameField(),
                  _buildrrepeat(),
                  _buildrtime(),
                  _buildrlimit(),
                  RaisedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        _formKey.currentState.save();
                        print("$_rname");
                        print("$_rtime");
                        print("$_rlimit");
                        print("$_rlimit");
                        insertdata();
                      }),
                  RaisedButton(
                    onPressed: delete,
                    child: Text("delete"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
