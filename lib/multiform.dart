import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MultiForm());

class MultiForm extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MultiForm> {
  List<DynamicWidget> listDynamic = [];
  List<String> data = [];
  String userEmail;

  Icon floatingIcon = new Icon(Icons.add);

  addDynamic() {
    if (data.length != 0) {
      floatingIcon = new Icon(Icons.add);
      data = [];
      listDynamic = [];
      print('if');
    }
    setState(() {});
    if (listDynamic.length >= 10) {
      return;
    }
    listDynamic.add(new DynamicWidget());
  }

  submitData() {
    data = [];
    listDynamic.forEach((widget) => data.add(widget.controller.text));
    setState(() {});
    print(data.length);
    sendData(data);
  }

  Future<String> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("email") ?? "no email";
  }

  sendData(List<String> data) async {
    CollectionReference collectionReference =
        Firestore.instance.collection("Binders");

    try {
      await collectionReference
          .document(userEmail == "no email" ? "hello2@gmail.com" : userEmail)
          .setData({"binder": data});
    } catch (e) {
      print("Error");
    }
  }

  @override
  void initState() {
    getEmail().then((value) {
      userEmail = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget result = new Flexible(
        flex: 1,
        child: new Card(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 10.0),
                      child: new Text("${index + 1} : ${data[index]}"),
                    ),
                    new Divider()
                  ],
                ),
              );
            },
          ),
        ));

    Widget dynamicTextField = new Flexible(
      flex: 2,
      child: new ListView.builder(
        itemCount: listDynamic.length,
        itemBuilder: (_, index) => listDynamic[index],
      ),
    );

    Widget submitButton = new Container(
      child: new RaisedButton(
        onPressed: submitData,
        child: new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Text('Buat Binder'),
        ),
      ),
    );

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Daftar Binder'),
          backgroundColor: Colors.red,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.add_box),
              label: Text(
                'Tambah Binder',
              ),
              onPressed: addDynamic,
            ),
          ],
        ),
        body: new Container(
          margin: new EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              data.length == 0 ? dynamicTextField : result,
              data.length == 0 ? submitButton : new Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class DynamicWidget extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.all(8.0),
      child: new TextField(
        controller: controller,
        decoration: new InputDecoration(hintText: 'Nama Binder '),
      ),
    );
  }
}
