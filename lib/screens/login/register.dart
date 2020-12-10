import 'package:flutter/material.dart';
import 'package:quero_contribuir/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to the app'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () => widget.toggleView(),
              icon: Icon(Icons.person),
              label: Text('Sign In')),
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 24.0),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Enter Email",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an e-mail.' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 24.0),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Enter Password",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) => val.length < 6
                      ? 'Password must contain at least 6 characters.'
                      : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.0),
                  child: RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(
                                () => error = 'Please supply a valid e-mail.');
                          }
                        }
                      }),
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          )),
    );
  }
}
