import 'package:flutter/material.dart';
import 'package:hello_world/authentication/sign_in.dart';
import 'package:hello_world/authentication/sign_up.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SingIn(toggleView: toggleView);
    } else {
      return SingUp(toggleView: toggleView);
    }
  }
}
