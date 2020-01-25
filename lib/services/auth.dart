import 'package:firebase_auth/firebase_auth.dart';
import 'package:letsmeet/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirbase(FirebaseUser user) {
    if (user != null) {
      return User(uid: user.uid);
    } else {
      return null;
    }
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirbase);
  }

//Singin Anonymousely
  Future SignInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      //eturn user;
      return _userFromFirbase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future RegisterWithEmailAndPass(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirbase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future LoginWithEmailAndPass(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirbase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future SignOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
