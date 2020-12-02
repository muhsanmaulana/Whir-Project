import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PreviewDownloadedImage extends StatelessWidget {
  final String path;

  const PreviewDownloadedImage({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Preview"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: PhotoView(
          imageProvider: FileImage(File(path)),
        ),
      ),
    );
  }
}
