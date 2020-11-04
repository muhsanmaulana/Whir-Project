import 'package:flutter/material.dart';
import 'package:hello_world/authentication/authenticate.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print("User : $user , from wrapper.dart");

    if (user == null) {
      return Authenticate();
    } else {
      return Navagation();
    }
  }
}
