import 'package:flutter/material.dart';
import 'package:hello_world/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService();
  String email = "email";
  String name = "name";

  Future<String> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("email") ?? "no email";
  }

  Future<String> getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("name") ?? "no name";
  }

  @override
  void initState() {
    getEmail().then((value) {
      email = value;
      setState(() {});
    });
    getName().then((value) {
      name = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        child: Text(name[0].toUpperCase()),
                        backgroundColor: Color(0xFFEE613A),
                        radius: 35.0),
                    SizedBox(height: 5.0),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      email,
                      style: TextStyle(fontSize: 12.0),
                    )
                  ],
                ),
                // SizedBox(width: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          '32',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Post',
                          style: TextStyle(fontSize: 12.0),
                        )
                      ],
                    ),
                    SizedBox(width: 20.0),
                    Column(
                      children: [
                        Text(
                          '32',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Followers',
                          style: TextStyle(fontSize: 12.0),
                        )
                      ],
                    ),
                    SizedBox(width: 20.0),
                    Column(
                      children: [
                        Text(
                          '32',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Following',
                          style: TextStyle(fontSize: 12.0),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
                width: double.infinity,
                height: 30.0,
                child: RaisedButton(
                    onPressed: () {},
                    color: Colors.red,
                    child: Text("Edit Profil",
                        style: TextStyle(color: Colors.white)))),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
                width: double.infinity,
                height: 30.0,
                child: RaisedButton(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    color: Colors.red,
                    child:
                        Text("Log out", style: TextStyle(color: Colors.white))))
          ],
        ),
      ),
    );
  }
}
