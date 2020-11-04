import 'package:flutter/material.dart';
import 'package:hello_world/catatan.dart';
import 'package:hello_world/notifikasi.dart';
import 'package:hello_world/profile.dart';
import 'package:hello_world/tambah.dart';

import 'jelajah.dart';

class Navagation extends StatefulWidget {
  @override
  _NavagationState createState() => _NavagationState();
}

class _NavagationState extends State<Navagation> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Catatan(),
    Jelajah(),
    Tambbah(),
    Notifikasi(),
    ProfilePage(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
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
              icon: Icon(Icons.add),
              label: 'Tambah',
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
}
