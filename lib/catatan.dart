import 'package:flutter/material.dart';

class Catatan extends StatefulWidget {
  @override
  _CatatanState createState() => _CatatanState();
}

class _CatatanState extends State<Catatan> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Catatan'),
          backgroundColor: Colors.red,
          elevation: 0.0,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Data Mining',
              ),
              Tab(
                text: 'Web Programming',
              ),
              Tab(
                text: 'Network',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
