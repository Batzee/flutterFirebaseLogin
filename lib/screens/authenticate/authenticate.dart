import 'package:flutter/material.dart';
import 'package:letsmeet/screens/authenticate/registerform.dart';
import 'package:letsmeet/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

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

  bool isSignIn = true;

  void toggleView(){
     setState(() {
       isSignIn = !isSignIn;
     });
  }

  @override
  Widget build(BuildContext context) {

    if(isSignIn){
      return SignIn(signInState: toggleView);
    }
    else{
      return RegisterForm(signInState: toggleView);
    }
  }
}