import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Catatan extends StatefulWidget {
  @override
  _CatatanState createState() => _CatatanState();
}

class _CatatanState extends State<Catatan> {
  List<Widget> tabs = [];

  Future<dynamic> _getFolders() async {
    CollectionReference collection = Firestore.instance.collection("Binders");

    String userEmail = await getEmail();

    var result = await collection.document(userEmail).get();

    return result.data["binder"];
  }

  Future<String> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("email") ?? "no email";
  }

  @override
  void initState() {
    _getFolders().then((value) {
      setState(() {
        for (var item in value) {
          tabs.add(Tab(
            text: item.toString(),
          ));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catatan'),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.red,
        child: DefaultTabController(
          length: tabs.length == 0 ? 1 : tabs.length,
          child: TabBar(
            indicatorColor: Colors.red[100],
            tabs: tabs.length == 0
                ? [
                    Tab(
                      text: "No Folder",
                    )
                  ]
                : tabs,
          ),
        ),
      ),
    );
  }
}
