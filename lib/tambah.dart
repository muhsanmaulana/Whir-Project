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
        title: Text('Tambah'),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      body: Center(
          child:
              _image == null ? Text("Image tidak loaded") : Image.file(_image)),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        backgroundColor: Colors.red,
        child: Icon(Icons.camera_alt),
        tooltip: 'Increment',
      ),
    );
  }
}