import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  TextEditingController etUsername = new TextEditingController();
  TextEditingController etPassword = new TextEditingController();

  String nUsername = "";
  String nPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Page 1'),
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
            ),
            TextFormField(
              controller: etUsername,
              decoration: InputDecoration(hintText: 'Input Username'),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    nUsername = etUsername.text;
                    nPassword = etPassword.text;
                  });
                },
                color: Colors.orange,
                textColor: Colors.white,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
