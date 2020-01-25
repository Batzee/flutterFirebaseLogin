import 'package:flutter/material.dart';
import 'package:letsmeet/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function signInState;
  SignIn({this.signInState});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sing In to Eat Together'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
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
                decoration: InputDecoration(hintText: 'Email'),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Password is Empty' : null,
                decoration: InputDecoration(hintText: 'Password'),
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.green[200],
                child: Text('Sign In'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result =
                        await _auth.LoginWithEmailAndPass(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Something went wrong, please try again later';
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 20.0),
              Text(error, style: TextStyle(color: Colors.red, fontSize: 14))
            ],
          ),
        ),
      ),
    );
  }
}
