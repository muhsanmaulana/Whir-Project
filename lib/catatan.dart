import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/binder/daftarcat.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'binder/image_data.dart';

class Catatan extends StatefulWidget {
  final String userEmail;

  const Catatan({this.userEmail});
  @override
  _CatatanState createState() => _CatatanState();
}

class _CatatanState extends State<Catatan> {
  List<Widget> tabs = [];
  var names = [];
  List<Widget> pinterestScreens = [];

  Future<dynamic> _getFolders() async {
    CollectionReference collection = Firestore.instance.collection("Binders");

    var result = await collection.document(widget.userEmail).get();

    return result.data["binder"];
  }

  @override
  void initState() {
    _getFolders().then((value) {
      if (value != null) {
        for (var item in value) {
          tabs.add(Tab(
            text: item.toString(),
          ));
          names.add(item.toString());
        }

        for (var name in names) {
          pinterestScreens.add(
            Tab(
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: PinterestGrid(
                    binderName: name,
                    userEmail: widget.userEmail,
                  )),
            ),
          );
        }
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This is such a 👎 comments
    // print("UserEmail : ${widget.userEmail} from catatan");
    // print("Tabs length form catatan : ${tabs.length}");
    // print("names length form catatan : ${names.length}");
    // print("pinterestScreens length form catatan : ${pinterestScreens.length}");

    return MaterialApp(
      home: DefaultTabController(
          length: tabs.length == 0 ? 1 : tabs.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Catatan"),
              backgroundColor: Colors.red,
              bottom: TabBar(
                indicatorColor: Colors.red[100],
                tabs: tabs.length == 0
                    ? [
                        Tab(
                          text: "No Binder",
                        )
                      ]
                    : tabs,
              ),
            ),
            body: tabs.length == 0
                ? Container(
                    child: Center(
                      child: Text("No File"),
                    ),
                  )
                : TabBarView(
                    children: pinterestScreens.length == 0
                        ? [
                            Container(
                              child: Center(
                                child: Text("No File"),
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Text("No File"),
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Text("No File"),
                              ),
                            ),
                          ]
                        : pinterestScreens,
                  ),
          )),
    );
  }
}
