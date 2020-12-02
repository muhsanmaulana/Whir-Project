import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:hello_world/downloaded_image_preview.dart';
import 'package:hello_world/multiform.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:sweetalert/sweetalert.dart';
import 'image_data.dart';
import 'package:http/http.dart' as http;

class StandardGrid extends StatelessWidget {
  const StandardGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: imageList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) => ImageCard(
        imageData: imageList[index],
      ),
    );
  }
}

class PinterestGrid extends StatefulWidget {
  final String userEmail;
  final String binderName;
  final bool isAll;

  PinterestGrid({this.binderName, this.userEmail, this.isAll = false});

  final DoubleHolder offset = new DoubleHolder();

  double getOffsetMethod() {
    return offset.value;
  }

  void setOffsetMethod(double val) {
    offset.value = val;
  }

  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class DoubleHolder {
  double value = 0.0;
}

class _PinterestGridState extends State<PinterestGrid> {
  List<ImageData> listOfImage;
  ScrollController controller;
  var filePath;

  Future<String> getEmailUser() async {
    SharedPreferences memory = await SharedPreferences.getInstance();

    return memory.getString("email");
  }

  Future<List<ImageData>> setListofImage() async {
    return await ImageData.getAllImageData(
        email: widget.userEmail, binderName: widget.binderName);
  }

  Future<List<ImageData>> getAllImageFromServer() async {
    return await ImageData.getAllImageDataFromServer();
  }

  image() {
    widget.isAll
        ? getAllImageFromServer().then((value) {
            listOfImage = value;
            setState(() {});
          })
        : setListofImage().then((value) {
            listOfImage = value;
            setState(() {});
          });
  }

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    image();

    super.initState();
  }

  void _scrollListener() {
    widget.setOffsetMethod(controller.position.pixels);
  }

  void _forceScroll(double offset) {
    controller.jumpTo(offset);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      listOfImage = widget.isAll ? ImageData.allImage : ImageData.dataImg;
    });

    return buildCustomScrollView(listOfImage);
  }

  Widget buildCustomScrollView(List<ImageData> data) {
    List<Widget> children = [];
    for (var image in data) {
      children.add(Container(
        child: ImageCard(
          imageData: image,
        ),
      ));
    }
    return Container(
      child: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(0.0),
            sliver: SliverGrid.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({this.imageData});

  final ImageData imageData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: GestureDetector(
          child: Image.network(imageData.imageUrl, fit: BoxFit.cover),
          onTap: () {
            showImageSheet(context, imageData.imageUrl);
          },
        ));
  }

  void showImageSheet(context, String imageUrl) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        context: context,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(imageUrl)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: RaisedButton(
                            color: Color(0xFFEE613A),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.download_rounded,
                                  color: Colors.white,
                                ),
                                Text("Simpan ke perangkat",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            onPressed: () async {
                              // _onImageSaveButtonPressed(imageUrl);
                              try {
                                // Saved with this method.
                                var imageId =
                                    await ImageDownloader.downloadImage(
                                        imageUrl);
                                if (imageId == null) {
                                  return;
                                }

                                // Below is a method of obtaining saved image information.
                                var fileName =
                                    await ImageDownloader.findName(imageId);
                                var path =
                                    await ImageDownloader.findPath(imageId);
                                var size =
                                    await ImageDownloader.findByteSize(imageId);
                                var mimeType =
                                    await ImageDownloader.findMimeType(imageId);

                                GallerySaver.saveImage(path);

                                SweetAlert.show(
                                  context,
                                  title: "Image Saved!",
                                  style: SweetAlertStyle.success,
                                );

                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) => PreviewDownloadedImage(
                                              path: path,
                                            )));

                                print(
                                    "fileName : $fileName, \n path : $path \n size : $size , \n mimeType : $mimeType");
                              } on PlatformException catch (error) {
                                print(error);
                              }
                            })),
                  )
                ],
              ));
        });
  }

  void _onImageSaveButtonPressed(String imageUrl) async {
    var response = await http.get(imageUrl);
    debugPrint(response.statusCode.toString());
    var filePath =
        await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
  }
}
