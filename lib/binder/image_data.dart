import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageData {
  final String id;
  final String imageUrl;
  static List<dynamic> dataImg;
  static List<ImageData> allImage = [];

  const ImageData({
    @required this.id,
    @required this.imageUrl,
  });

  static Future<List<ImageData>> getAllImageData(
      {String email, String binderName}) async {
    CollectionReference collectionReference =
        Firestore.instance.collection("BinderList");

    var result = await collectionReference
        .document(email)
        .collection(binderName)
        .getDocuments();

    if (email == null) {
      AlertDialog(
        content: Text("Null Email"),
      );
    }

    List<ImageData> listImage = [];

    for (var document in result.documents) {
      listImage.add(
        ImageData(
          id: result.documents.indexOf(document).toString(),
          imageUrl: document["link"].toString(),
        ),
      );
    }
    // print("Image_Data 🔥 : ${listImage[0].imageUrl}");
    dataImg = listImage;
    return listImage;
  }

  static Future<List<ImageData>> getAllImageDataFromServer() async {
    CollectionReference bindersRef = Firestore.instance.collection("Binders");
    CollectionReference usersRef = Firestore.instance.collection("users");

// Get all users email
    var usersResult = await usersRef.getDocuments();
    List<String> usersEmail = [];

    for (var document in usersResult.documents) {
      usersEmail.add(document.documentID);
    }
    // print("Get All Email from server , From Image_data : ${usersEmail} ");

// for all user in usersEmail get all binder
    for (var email in usersEmail) {
      var bindersResult = await bindersRef.document(email).get();
      List<String> binderName = [];

      if (bindersResult.data != null) {
        bindersResult.data.forEach((key, value) {
          binderName = [...binderName, ...value];
        });
      }

      // for (var binder in bindersResult.data.values) {
      //   binderName.add(binder.toString());
      // }

      // print("$email : $binderName");

      if (binderName != null) {
        // print("binderName length : ${binderName.length}");

        if (binderName.length != 0) {
          binderName.forEach((element) {
            // List<ImageData> temp =
            //     await getAllImageData(email: email, binderName: element);
            // allImage = [...allImage, ...temp];

            getAllImageData(email: email, binderName: element).then((value) {
              // print("I'm inside");
              for (var data in value) {
                allImage.add(data);
              }
            });
          });
        }
      }
    }

// if (email == null) {
// AlertDialog(
// content: Text("Null Email"),
// );
// }

    // print("all Image_Data 🔥 : $allImage");

    return allImage;
  }
}

const imageList = [
  ImageData(
    id: 'id-001',
    imageUrl: 'https://picsum.photos/seed/image002/500/800',
  ),
  ImageData(
    id: 'id-002',
    imageUrl: 'https://picsum.photos/seed/image002/500/800',
  ),
  ImageData(
    id: 'id-003',
    imageUrl: 'https://picsum.photos/seed/image003/500/300',
  ),
  ImageData(
    id: 'id-004',
    imageUrl: 'https://picsum.photos/seed/image004/500/900',
  ),
  ImageData(
    id: 'id-005',
    imageUrl: 'https://picsum.photos/seed/image005/500/600',
  ),
  ImageData(
    id: 'id-006',
    imageUrl: 'https://picsum.photos/seed/image006/500/500',
  ),
  ImageData(
    id: 'id-007',
    imageUrl: 'https://picsum.photos/seed/image007/500/400',
  ),
  ImageData(
    id: 'id-008',
    imageUrl: 'https://picsum.photos/seed/image008/500/700',
  ),
  ImageData(
    id: 'id-009',
    imageUrl: 'https://picsum.photos/seed/image009/500/600',
  ),
  ImageData(
    id: 'id-010',
    imageUrl: 'https://picsum.photos/seed/image010/500/900',
  ),
  ImageData(
    id: 'id-011',
    imageUrl: 'https://picsum.photos/seed/image011/500/900',
  ),
  ImageData(
    id: 'id-012',
    imageUrl: 'https://picsum.photos/seed/image012/500/700',
  ),
  ImageData(
    id: 'id-013',
    imageUrl: 'https://picsum.photos/seed/image013/500/700',
  ),
  ImageData(
    id: 'id-014',
    imageUrl: 'https://picsum.photos/seed/image014/500/800',
  ),
  ImageData(
    id: 'id-015',
    imageUrl: 'https://picsum.photos/seed/image015/500/500',
  ),
  ImageData(
    id: 'id-016',
    imageUrl: 'https://picsum.photos/seed/image016/500/700',
  ),
  ImageData(
    id: 'id-017',
    imageUrl: 'https://picsum.photos/seed/image017/500/600',
  ),
  ImageData(
    id: 'id-018',
    imageUrl: 'https://picsum.photos/seed/image018/500/900',
  ),
  ImageData(
    id: 'id-019',
    imageUrl: 'https://picsum.photos/seed/image019/500/800',
  ),
];
