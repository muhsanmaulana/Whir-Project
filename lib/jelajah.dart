import 'package:flutter/material.dart';

class Jelajah extends StatefulWidget {
  @override
  _JelajahState createState() => _JelajahState();
}

class _JelajahState extends State<Jelajah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jelajah'),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
    );
  }
}
