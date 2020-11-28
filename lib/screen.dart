import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/catatan.dart';
import 'package:hello_world/notifikasi.dart';
import 'package:hello_world/profile.dart';
import 'package:hello_world/uploaddetail.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'jelajah.dart';

class Navagation extends StatefulWidget {
  final String userEmail;

  const Navagation({this.userEmail});
  @override
  _NavagationState createState() => _NavagationState();
}

class _NavagationState extends State<Navagation> {
  int _currentIndex = 0;
  String userEmail;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<String> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("email");
  }

  @override
  void initState() {
    getEmail().then((value) {
      userEmail = value ?? "hello";
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      Catatan(
        userEmail: widget.userEmail,
      ),
      Jelajah(),
      Detail(),
      Notifikasi(),
      ProfilePage(),
    ];
    return Scaffold(
      body: _children[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _optionGambar(context);
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.camera_alt),
        tooltip: 'Increment',
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        backgroundColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Catatan',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Jelajah',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.circle),
              label: 'Linimasa',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifikasi',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
              backgroundColor: Colors.red),
        ],
      ),
    );
  }

  void _optionGambar(context) {
    File _image;
    String filename;
    Future getImage() async {
      final image = await ImagePicker.pickImage(source: ImageSource.camera);

      setState(() {
        _image = image;
      });

      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => Detail(
            image: image,
          ),
        ),
      );
    }

    Future getGalery() async {
      final image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => Detail(
            image: image,
          ),
        ),
      );
    }

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        context: context,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tambah Catatan",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.photo),
                              onPressed: getGalery,
                            ),
                            Text("Galeri")
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: getImage,
                            ),
                            Text("Kamera")
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}
