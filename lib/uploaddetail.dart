import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class Detail extends StatefulWidget {
  final File image;

  const Detail({Key key, this.image}) : super(key: key);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  List<Widget> opsi = [];
  List<String> binder = [];
  String selectedRadio;
  String userEmail;

  String namaCatatan = "";
  bool isLoad = true;

  TextEditingController namaCat = new TextEditingController();

  Future<dynamic> _getFolders() async {
    CollectionReference collection = Firestore.instance.collection("Binders");

    String userEmail = await getEmail();

    var result = await collection.document(userEmail).get();

    return result.data["binder"];
  }

  Future<String> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("email") ?? "no email";
  }

  kirimData(String downloadUrl, String binderName, String fileName) async {
    CollectionReference collectionReference =
        Firestore.instance.collection("BinderList");

    try {
      await collectionReference
          .document(userEmail == "no email" ? "hello2@gmail.com" : userEmail)
          .collection(binderName)
          .document(fileName)
          .setData({"link": downloadUrl});
    } catch (e) {
      print("Error");
    }
  }

  @override
  void initState() {
    if (widget.image != null) {
      List<String> splitPath = widget.image.path.split('/');
      namaCatatan = splitPath[splitPath.length - 1];
    } else {
      namaCatatan = "whir.png";
    }
    namaCat.text = namaCatatan;

    selectedRadio = "";
    getEmail().then((value) {
      userEmail = value;
      setState(() {});
    });
    _getFolders().then((value) {
      setState(() {
        for (var item in value) {
          binder.add(item);
        }
      });
    });
    super.initState();
  }

  setSelectedRadio(String val) {
    setState(() {
      selectedRadio = val;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
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
                child: widget.image == null
                    ? Image(
                        image: AssetImage(
                        "assets/logo.jpg",
                      ))
                    : Image.file(widget.image),
              ),
              SizedBox(height: 10.0),

              Container(
                child: Form(
                    child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: namaCat,
                      decoration: InputDecoration(hintText: 'Nama Catatan'),
                    ),
                  ],
                )),
              ),

              SizedBox(height: 20.0),

              Text("Pilih Binder"),
              Column(children: <Widget>[
                for (var item in binder)
                  RadioListTile(
                    title: Text(item.toString()),
                    value: item,
                    groupValue: selectedRadio,
                    activeColor: Colors.red,
                    onChanged: (nothing) {
                      setState(() {
                        print(nothing);
                        setSelectedRadio(item);
                        namaCatatan = namaCat.text;
                      });
                    },
                  )
              ]),

              SizedBox(height: 20.0),
              Container(),
              FlatButton(
                  onPressed: () async {
                    FirebaseStorage _storage = FirebaseStorage.instance;

                    List<String> splitPath = widget.image.path.split('/');
                    String filename = splitPath[splitPath.length - 1];

                    StorageReference reference =
                        _storage.ref().child("images").child(filename);

                    StorageUploadTask uploadTask =
                        reference.putFile(widget.image);

                    StreamSubscription streamSubscription =
                        uploadTask.events.listen((event) async {
                      var eventType = event.type;

                      if (eventType == StorageTaskEventType.progress) {
                      } else if (eventType == StorageTaskEventType.failure) {
                        scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text('Photo failed to upload'),
                          ),
                        );
                      } else if (eventType == StorageTaskEventType.success) {
                        var downloadUrl =
                            await event.snapshot.ref.getDownloadURL();

                        kirimData(
                          downloadUrl.toString(),
                          selectedRadio,
                          namaCatatan,
                        );
                        setState(() {
                          isLoad = false;
                        });

                        SweetAlert.show(
                          context,
                          title: "Success 🎉",
                          subtitle: "File was Uploaded succcessful",
                          style: SweetAlertStyle.success,
                        );

                        // Navigator.pop(context);

                        // scaffoldState.currentState.showSnackBar(
                        //   SnackBar(
                        //     content: Text('Photo uploaded successfully'),
                        //   ),
                        // );
                      }
                    });
                    await uploadTask.onComplete;

                    streamSubscription.cancel();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("Unggah"))
            ],
          ),
        ));
  }
}

class Firebase {
  static Future<FirebaseApp> initializeApp() async {
    return await Firebase.initializeApp();
  }
}

// Future<String> uploadImage() async {
//   StorageReference ref = FirebaseStorage.instance.ref().child(path);
// }
