import 'package:flutter/material.dart';
import 'package:letsmeet/models/user.dart';
import 'package:letsmeet/screens/authenticate/authenticate.dart';
import 'package:letsmeet/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if(user == null){
    //return home or authenticate
    return Authenticate();
    }
    else{
      return Home();
    }
  }
}