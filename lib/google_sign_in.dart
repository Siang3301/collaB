import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

    } catch (e){
      // ignore: avoid_print
      print(e.toString());
    }
    notifyListeners();
  }

  Future logout() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

}

abstract class BaseAuth{
  Future<String> signInWithEmailAndPassword(String email,String password);
  Future<String> createUserWithEmailAndPassword(String email,String password);
}

/*class Auth implements GoogleAuth{
  Future<String> signInWithEmailAndPassword(String email, String password) async{
    final user = await FirebaseAuth.instance.currentUser!;
    return user.uid;
  }
  Future<String> createUserWithEmailAndPassword(String email,String password) async{
    final user = await FirebaseAuth.instance.currentUser!;
    return user.uid;
  }
}*/