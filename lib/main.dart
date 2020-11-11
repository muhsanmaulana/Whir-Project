import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/services/auth.dart';
import 'package:hello_world/authentication/wrapper.dart';
import 'package:hello_world/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        title: "Whir",
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
