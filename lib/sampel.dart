import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() => runApp(Sample());

class Sample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class DoubleHolder {
  double value = 0.0;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final DoubleHolder offset = new DoubleHolder();

  double getOffsetMethod() {
    // print('getOffsetMethod : ' + offset.value.toString());
    return offset.value;
  }

  void setOffsetMethod(double val) {
    print('offset : ' + offset.value.toString());
    offset.value = val;
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController controller;

  List<int> items = [];
  void _addList() {
    setState(() {
      var last = items.last;

      for (var i = 0; i < 10; i++) {
        items.add(last + i);
      }
    });
  }

  void _scrollListener() {
    widget.setOffsetMethod(controller.position.pixels);
  }

  void _forceScroll(double offset) {
    controller.jumpTo(offset);
    print('forceScroll to : ' + offset.toString());
  }

  @override
  void initState() {
    super.initState();

    controller = ScrollController()..addListener(_scrollListener);

    for (var i = 0; i < 10; i++) {
      items.add(i);
    }
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: StaggeredGridView.countBuilder(
        controller: controller,
        crossAxisCount: 2,
        itemCount: items.length,
        staggeredTileBuilder: (int index) {
          return StaggeredTile.fit(1);
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Text('ListTile $index.'),
              subtitle: Hero(
                tag: index,
                child: Image.network(
                  'https://media2.giphy.com/media/TlS1r2W12aUZG/giphy.webp',
                  fit: BoxFit.cover,
                ),
                // child: Container(
                //   width: 200,
                //   height: 400,
                //   color: Colors.blue,
                // ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HelloPage(
                            index, _forceScroll, widget.getOffsetMethod())));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addList,
        child: Icon(Icons.add),
      ),
    );
  }
}

class HelloPage extends StatelessWidget {
  HelloPage(this.index, this.callback, this.offset);

  final int index;
  final Function(double offset) callback;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
                callback(offset);
              },
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello $index',
              style: TextStyle(fontSize: 50.0),
            ),
            Hero(
              tag: index,
              child: Image.network(
                'https://media2.giphy.com/media/TlS1r2W12aUZG/giphy.webp',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
