import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'package:hello_world/services/auth.dart';

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0.0,
          title: Text('Sign in to Whir'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign Up'),
              onPressed: () => widget.toggleView(),
            ),
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 150.0,
                      child: Image(
                        image: AssetImage('assets/logo_t.png'),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Masukkan email' : null,
                      decoration: const InputDecoration(
                          hintText: 'Masukkan email', labelText: 'Email '),
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Masukkan password' : null,
                      decoration: const InputDecoration(
                          hintText: 'Masukkan password',
                          labelText: 'Password '),
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 40.0,
                        child: RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Gagal log in ';
                                  });
                                }
                              }
                            },
                            color: Colors.red,
                            child: Text("Sign In",
                                style: TextStyle(color: Colors.white)))),
                    SizedBox(height: 20.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ))));
  }
}
