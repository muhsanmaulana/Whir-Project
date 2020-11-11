import 'package:flutter/material.dart';
import 'package:hello_world/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingIn extends StatefulWidget {
  final Function toggleView;
  SingIn({this.toggleView});
  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    double tinggiLayar =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;

    double lebarLayar =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: tinggiLayar,
          padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: tinggiLayar / 6,
                  child: Image(
                    image: AssetImage('assets/logo_t.png'),
                  ),
                ),
                SizedBox(height: tinggiLayar / 15),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Masukkan email' : null,
                  decoration: const InputDecoration(
                      hintText: 'Masukkan email', labelText: 'Email '),
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Masukkan password' : null,
                  decoration: const InputDecoration(
                      hintText: 'Masukkan password', labelText: 'Password '),
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 15),
                Container(
                  width: lebarLayar,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Gagal log in ';
                          });
                        } else {
                          String name = await _auth.getName(email: email);
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString("email", email);
                          sharedPreferences.setString("name", name);
                        }
                      }
                    },
                    color: Colors.red,
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => widget.toggleView(),
                      child: Text(
                        "Register now!",
                        style: TextStyle(
                          color: Color(0xFFEE613A),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
