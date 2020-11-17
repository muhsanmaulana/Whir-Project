import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Tambbah extends StatefulWidget {
  @override
  _TambbahState createState() => _TambbahState();
}

class _TambbahState extends State<Tambbah> {
  File _image;
  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Linimasa'),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      body: Form(
          //key: form,
          child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20.0),
            AppBar(
              leading: Icon(Icons.verified_user),
              elevation: 0,
              title: Text('User Details'),
              backgroundColor: Theme.of(context).accentColor,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: TextFormField(
                // initialValue: widget.user.fullName,
                // onSaved: (val) => widget.user.fullName = val,
                validator: (val) =>
                    val.length > 3 ? null : 'Full name is invalid',
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  icon: Icon(Icons.person),
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
