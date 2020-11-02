import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/services/auth.dart';
import 'package:hello_world/authentication/wrapper.dart';
import 'package:hello_world/models/user.dart';
//import 'dart:core' as prefix0;
//import 'package:hello_world/profile.dart';
//import 'profile.dart';
import 'registrasi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
