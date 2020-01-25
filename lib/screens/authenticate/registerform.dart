import 'package:flutter/material.dart';
import 'package:letsmeet/services/auth.dart';
import 'package:letsmeet/shared/constants.dart';
import 'package:letsmeet/shared/loading.dart';

class RegisterForm extends StatefulWidget {
  final Function signInState;

  RegisterForm({this.signInState});
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign Up and Lets Eat'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () {
                    widget.signInState();
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Email is Empty' : null,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Password must more than 5 characters long'
                          : null,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.green[40],
                      child: Text('Register'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.RegisterWithEmailAndPass(
                              email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'Something went wrong, please try again later';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20.0),
                    Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14))
                  ],
                ),
              ),
            ),
          );
  }
}
