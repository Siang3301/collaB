import 'package:collab/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Email Login
class EmailAuthentication {

  // 1
  final FirebaseAuth _firebaseAuth;

  EmailAuthentication(this._firebaseAuth);

  // 2
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();


  // 3
  Future<String?> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch(e) {
      return e.message;
    }
  }

  // 4
  Future<String?> signUp({required String email, required String password, required String name}) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      _firebaseAuth.currentUser!.updateDisplayName(name);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData(name, '01x-xxxxxxx', 'Edit yourself now!');

      return "Signed up";
    } on FirebaseAuthException catch(e) {
      return e.message;
    }
  }

  // 5
  Future<String?> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Signed out";
    } on FirebaseAuthException catch(e) {
      return e.message;
    }
  }

// 6
  User? getUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException {
      return null;
    }
  }

}

