import 'package:flutter/material.dart';
import 'package:hello_world/services/auth.dart';

class ProfilePage extends StatelessWidget {
  final AuthService _auth = AuthService();

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
                        backgroundImage: AssetImage('assets/profil_pic.jpg'),
                        radius: 35.0),
                    SizedBox(height: 5.0),
                    Text(
                      'Muhsan Maulana',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'emailmuhsan@gmail.com',
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
