import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;
  static String username ='';
  static String phone ='';
  static String bio = '';
  DatabaseService({ required this.uid });

  final CollectionReference usersData = FirebaseFirestore.instance.collection('users_data');

  Future updateUserData(String username, String phone, String bio, String email, String uid) async {
    return await usersData.doc(uid).set({
      'username' :username,
      'phone' :phone,
      'bio' :bio,
      'email' :email,
      'uid' :uid,
    });
    }

  Stream<QuerySnapshot> get users{
    return usersData.snapshots();
  }

  Future getCurrentUserData() async{
    try {
      DocumentSnapshot value = await usersData.doc(uid).get();
      username = value.get('username');
      phone = value.get('phone');
      bio = value.get('bio');
    }catch(e){
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  Future uploadProfilePicToFirebase(BuildContext context, File _imageFile) async {
    String fileName = FirebaseAuth.instance.currentUser!.uid;
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('users/ProfilePicture/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          // ignore: avoid_print
          (value) => print("Done: $value"),
    );
  }

}