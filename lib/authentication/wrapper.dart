import 'package:flutter/material.dart';
import 'package:hello_world/authentication/authenticate.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  SharedPreferences memory;
  Future<SharedPreferences> setEmailInMemory() async {
    SharedPreferences temp = await SharedPreferences.getInstance();
    return temp;
  }

  @override
  void initState() {
    setEmailInMemory().then((value) {
      this.memory = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print("User : ${user} , from wrapper.dart");

    if (user == null) {
      return Authenticate();
    } else {
      this.memory.setString("email", user.uemail);
      this.memory.setString("name", user.uname);
      return Navagation(
        userEmail: user.uemail,
      );
    }
  }
}
