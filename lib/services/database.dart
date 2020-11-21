import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference binder = Firestore.instance.collection('binder');

  // final String uid;

//   DatabaseService(this.uid);

//   Future updateUserData (String binder) async{

//      return await binder.document(uid).setData({
//       'binder' : binder,

// })

}
