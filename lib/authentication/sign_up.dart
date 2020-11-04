import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'package:hello_world/services/auth.dart';

class SingUp extends StatefulWidget {
  final Function toggleView;
  SingUp({this.toggleView});
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          backgroundColor: Colors.red,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              onPressed: () => widget.toggleView(),
            ),
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
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
                      decoration: const InputDecoration(
                          hintText: 'Masukkan password',
                          labelText: 'Password '),
                      obscureText: true,
                      validator: (val) =>
                          val.isEmpty ? 'Masukkan password' : null,
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
                                dynamic result = await _auth.registerEmailPass(
                                    email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Masukkan email valid';
                                  });
                                }
                              }
                            },
                            color: Colors.red,
                            child: Text("Sign Up",
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

// SizedBox(
//                   height: 30.0,
//                   child: FlatButton(
//                     child: Text('Belum punya akun ? Sign Up'),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => SingUp(),
//                           ));
//                     },
//                   ),
//                 ),