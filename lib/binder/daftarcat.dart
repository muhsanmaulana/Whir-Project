import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'image_data.dart';

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
    // print('getOffsetMethod : ' + offset.value.toString());
    return offset.value;
  }

  void setOffsetMethod(double val) {
    // print('offset : ' + offset.value.toString());
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

  //

  void _scrollListener() {
    widget.setOffsetMethod(controller.position.pixels);
  }

  void _forceScroll(double offset) {
    controller.jumpTo(offset);
    // print('forceScroll to : ' + offset.toString());
  }

  //

  @override
  Widget build(BuildContext context) {
    setState(() {
      listOfImage = widget.isAll ? ImageData.allImage : ImageData.dataImg;
    });
    // damn 👎 comments , but it works 👍.
    // print("from daftarcat.dart : ${widget.binderName}");
    // setState(() {});
    // print(
    //     "Length of ListofImage in daftarcat.dart : ${ImageData.dataImg == null ? 0 : ImageData.dataImg.length}");

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
      child: Image.network(imageData.imageUrl, fit: BoxFit.cover),
    );
  }
}
