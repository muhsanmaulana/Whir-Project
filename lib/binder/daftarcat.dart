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
  PinterestGrid({this.binderName, this.userEmail});

  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  List<ImageData> listOfImage;

  Future<String> getEmailUser() async {
    SharedPreferences memory = await SharedPreferences.getInstance();

    return memory.getString("email");
  }

  Future<List<ImageData>> setListofImage() async {
    return await ImageData.getAllImageData(
        email: widget.userEmail, binderName: widget.binderName);
  }

  @override
  void initState() {
    setListofImage().then((value) {
      listOfImage = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      listOfImage = ImageData.dataImg;
    });
    // damn 👎 comments , but it works 👍.
    // print("from daftarcat.dart : ${widget.binderName}");
    // setState(() {});
    // print(
    //     "Length of ListofImage in daftarcat.dart : ${ImageData.dataImg == null ? 0 : ImageData.dataImg.length}");

    return buildCustomScrollView();
  }

  Widget buildCustomScrollView() {
    List<Widget> children = [];
    for (var image in listOfImage) {
      children.add(ImageCard(
        imageData: image,
      ));
    }
    Widget child = buildStaggeredGridView();
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

  Widget buildStaggeredGridView() {
    return StaggeredGridView.countBuilder(
      physics: ScrollPhysics(),
      crossAxisCount: 2,
      itemCount: listOfImage == null ? 0 : listOfImage.length,
      itemBuilder: (context, index) => ImageCard(
        imageData: listOfImage[index],
      ),
      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
    ;
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
