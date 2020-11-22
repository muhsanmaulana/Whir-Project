import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Tambah Catatan"),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5.0),
              // Gambar yang udh diaplot
              Container(
                alignment: Alignment.center,
                height: 200.0,
                child: Image(
                  image: AssetImage(
                    "assets/logo.jpg",
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(),
              FlatButton(
                  onPressed: () {},
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("Unggah"))
            ],
          ),
        ));
  }
}
