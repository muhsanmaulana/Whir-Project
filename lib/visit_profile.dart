import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Visit extends StatefulWidget {
  @override
  _VisitState createState() => _VisitState();
}

class _VisitState extends State<Visit> {
  @override
  Widget build(BuildContext context) {
    final title = 'Florin Karmina';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
            title: Text(title), backgroundColor: Colors.red, elevation: 0.0),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: new Image.asset('img/florin.png'),
                        ),
                        backgroundColor: Color(0xFFEE613A),
                        radius: 35.0),
                    SizedBox(width: 20.0),
                    Column(
                      children: [
                        Text(
                          '32',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Post',
                          style: TextStyle(fontSize: 15.0),
                        )
                      ],
                    ),
                    SizedBox(width: 20.0),
                    Column(
                      children: [
                        Text(
                          '32',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Followers',
                          style: TextStyle(fontSize: 15.0),
                        )
                      ],
                    ),
                    SizedBox(width: 20.0),
                    Column(
                      children: [
                        Text(
                          '32',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Following',
                          style: TextStyle(fontSize: 15.0),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 5.0),
                Text(
                  'Florin Karmina',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  'florinkarmina@gmail.com',
                  style: TextStyle(fontSize: 12.0),
                ),
                SizedBox(height: 10.0),
                SizedBox(
                    width: double.infinity,
                    height: 30.0,
                    child: RaisedButton(
                        onPressed: () {},
                        color: Colors.red,
                        child: Text("Mengikuti",
                            style: TextStyle(color: Colors.white)))),
                SizedBox(height: 10.0),
                Expanded(
                    child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        children: [
                      Image.asset('img/florin.png'),
                      Image.asset('img/florin.png'),
                      Image.asset('img/florin.png'),
                      Image.asset('img/gambr.png'),
                      Image.asset('img/gambr.png'),
                      Image.asset('img/gambr.png'),
                      Image.asset('img/gambr.png'),
                      Icon(Icons.android),
                      Icon(Icons.android),
                      Icon(Icons.android),
                      Icon(Icons.android),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
