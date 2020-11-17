import 'package:flutter/material.dart';

class Notifikasi extends StatefulWidget {
  @override
  _NotifikasiState createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          new ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: new Image.asset('assets/profil_pic.jpg'),
            ),
            title: new Container(
              child: new Column(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(top: 8.0),
                    child: new Text(
                      'Muhsan Maulana telah mengunggah 5 berkas baru pada folder Soal UTS 2016',
                      style: new TextStyle(fontSize: 15.0),
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.all(5.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: new Text(
                          '2 jam yang lalu',
                          style:
                              new TextStyle(color: Colors.grey, fontSize: 13.0),
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 260,
                        child: new Image.asset("img/gambr.png"),
                      ),
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.all(5.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: new Text(
                          'Lihat Folder',
                          style: new TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.underline,
                              fontSize: 13.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
