import 'package:flutter/material.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService();
  String email = "email";
  String name = "name";
  //for search
  final TextEditingController _filter = new TextEditingController();
  bool isCollapse = false;
  String _searchText = "";
  List<User> users = [];
  List filteredNames = [];
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text('Profil');

  _ProfilePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = users;
          isCollapse = false;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          isCollapse = true;
        });
      }
    });
  }

  // end of search

  Future<String> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("email") ?? "no email";
  }

  Future<String> getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("name") ?? "no name";
  }

  @override
  void initState() {
    getEmail().then((value) {
      email = value;
      setState(() {});
    });
    getName().then((value) {
      name = value;
      setState(() {});
    });
    _getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: isCollapse && this._filter.text.isNotEmpty
              ? _buildList()
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                child: Text(name[0].toUpperCase()),
                                backgroundColor: Color(0xFFEE613A),
                                radius: 35.0),
                            SizedBox(height: 5.0),
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              email,
                              style: TextStyle(fontSize: 12.0),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '32',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Post',
                                  style: TextStyle(fontSize: 12.0),
                                )
                              ],
                            ),
                            SizedBox(width: 20.0),
                            Column(
                              children: [
                                Text(
                                  '32',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Followers',
                                  style: TextStyle(fontSize: 12.0),
                                )
                              ],
                            ),
                            SizedBox(width: 20.0),
                            Column(
                              children: [
                                Text(
                                  '32',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Following',
                                  style: TextStyle(fontSize: 12.0),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 30.0,
                        child: RaisedButton(
                            onPressed: () {},
                            color: Colors.red,
                            child: Text("Edit Profil",
                                style: TextStyle(color: Colors.white)))),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 30.0,
                        child: RaisedButton(
                            onPressed: () async {
                              await _auth.signOut();
                            },
                            color: Colors.red,
                            child: Text("Log out",
                                style: TextStyle(color: Colors.white))))
                  ],
                ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: this._appBarTitle,
      backgroundColor: Colors.red,
      elevation: 0.0,
      actions: [
        IconButton(
          icon: this._searchIcon,
          onPressed: this._searchPressed,
        ),
      ],
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          autofocus: true,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Profil');
        filteredNames = users;
        _filter.clear();
      }
    });
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .uname
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: users == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        bool ischecked = false;
        return ListTile(
          leading: CircleAvatar(
              child: Text(filteredNames[index].uname[0].toUpperCase()),
              backgroundColor: Color(0xFFEE613A),
              radius: 20.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(filteredNames[index].uname),
              RaisedButton(
                onPressed: () {
                  ischecked = !ischecked;
                  setState(() {});
                },
                color: Color(0xFFEE613A),
                child: Text(
                  ischecked ? "following" : "follow",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          onTap: () {},
        );
      },
    );
  }

  void _getUsers() async {
    CollectionReference collection = Firestore.instance.collection("users");

    var result = await collection.getDocuments();
    setState(() {
      for (var doc in result.documents) {
        String tempmail = doc.data["email"] ?? null;
        String tempName = doc.data["name"] ?? null;
        if (tempmail != null && tempName != null) {
          users.add(User(uemail: tempmail, uname: tempName));
        }
      }
    });
  }
}
